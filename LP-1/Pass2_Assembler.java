import java.util.*;

public class Pass2_Assembler {

    static class Symbol {
        String name;
        int address;
        Symbol(String name, int address) {
            this.name = name;
            this.address = address;
        }
    }

    static class Literal {
        String literal;
        int address;
        Literal(String literal, int address) {
            this.literal = literal;
            this.address = address;
        }
    }

    public static void main(String[] args) {
        List<Symbol> SYMTAB = new ArrayList<>();
        SYMTAB.add(new Symbol("ALPHA", 202));

        List<Literal> LITTAB = new ArrayList<>();
        LITTAB.add(new Literal("='5'", 203));

        List<String> IC = Arrays.asList(
            "(AD,1) (C,200)",
            "(IS,4) (1) (L,1)",
            "(IS,1) (2) (S,1)",
            "(DL,1) (C,2)",
            "(AD,2)"
        );

        int LC = 0;

        for (String line : IC) {
            line = line.trim();

            if (line.startsWith("(AD,")) {
                if (line.startsWith("(AD,1)")) {
                    String[] parts = line.split("[()]");
                    for (String part : parts) {
                        if (part.startsWith("C,")) {
                            LC = Integer.parseInt(part.substring(2));
                        }
                    }
                }
                continue;
            }

            else if (line.startsWith("(IS,")) {
                String[] parts = line.split(" ");
                int opcode = Integer.parseInt(parts[0].substring(4, parts[0].length() - 1));
                int reg = 0;
                if (parts.length > 1 && parts[1].startsWith("(")) {
                    reg = Integer.parseInt(parts[1].substring(1, parts[1].length() - 1));
                }
                int operandAddr = 0;
                if (parts.length > 2) {
                    String op = parts[2];
                    if (op.startsWith("(S,")) {
                        int symIndex = Integer.parseInt(op.substring(3, op.length() - 1));
                        operandAddr = SYMTAB.get(symIndex - 1).address;
                    }
                    else if (op.startsWith("(L,")) {
                        int litIndex = Integer.parseInt(op.substring(3, op.length() - 1));
                        operandAddr = LITTAB.get(litIndex - 1).address;
                    }
                    else if (op.startsWith("(C,")) {
                        operandAddr = Integer.parseInt(op.substring(3, op.length() - 1));
                    }
                }
                System.out.println(LC + " " + opcode + " " + reg + " " + operandAddr);
                LC++;
            }

            else if (line.startsWith("(DL,")) {
                String[] parts = line.split(" ");
                int val = 0;
                for (String part : parts) {
                    if (part.startsWith("(C,")) {
                        val = Integer.parseInt(part.substring(3, part.length() - 1));
                    }
                }
                System.out.println(LC + " 00 0 " + val);
                LC++;
            }
        }
    }
}


/*

🧠 Theory: Pass 2 Assembler

The second pass of an assembler uses the output of Pass 1 to generate the actual machine code.

Input: Intermediate Code (IC), Symbol Table, Literal Table.

Output: Final Machine Code.

Objective: Replace symbolic addresses and literals with their actual memory locations.

During Pass 2:

Assembler directives (AD) are ignored since they were handled in Pass 1.

Imperative statements (IS) are converted to machine code using the opcode, register code, and actual addresses of symbols/literals.

Declarative statements (DL) allocate memory and initialize data.

The location counter (LC) is updated for each instruction.

⚙️ Algorithm: Pass 2 Assembler

Start.

Read SYMTAB, LITTAB, and Intermediate Code (IC) from Pass 1 output.

Initialize LC = 0.

For each line in IC:

    - If it contains an Assembler Directive (AD) → skip.

    - If it contains an Imperative Statement (IS):

        + Extract opcode, register code, and operand.

        + Replace symbols/literals with their actual addresses from SYMTAB/LITTAB.

        + Print corresponding machine code instruction.

        + Increment LC.

    - If it contains a Declarative Statement (DL):

        + Assign the constant value to memory.

        + Increment LC.

Continue until the entire IC is processed.

Stop.

 */