import java.util.*;

class Pass2_MacroP {

    static class MNTEntry {
        String name;
        int mdtIndex;

        public MNTEntry(String name, int mdtIndex) {
            this.name = name;
            this.mdtIndex = mdtIndex;
        }
    }

    static class Pass2 {

        List<MNTEntry> MNT;
        List<String> MDT;
        List<String> intermediateCode;
        List<Map<String, String>> ALA;

        public Pass2(List<MNTEntry> MNT, List<String> MDT, List<String> IC, List<Map<String, String>> ALA) {
            this.MNT = MNT;
            this.MDT = MDT;
            this.intermediateCode = IC;
            this.ALA = ALA;
        }

        public void expandCode() {
            // Show Before/After first
            for (int m = 0; m < MNT.size(); m++) {
                Map<String, String> ala = ALA.get(m);
                for (Map.Entry<String, String> entry : ala.entrySet()) {
                    String formal = entry.getKey();   // &X
                    String positional = entry.getValue(); // #0
                    // Find actual argument from intermediate code
                    for (String line : intermediateCode) {
                        String[] parts = line.split("\\s+");
                        if (parts[0].equals(MNT.get(m).name)) {
                            String[] args = Arrays.copyOfRange(parts, 1, parts.length);
                            int index = Integer.parseInt(positional.substring(1));
                            if (index < args.length) {
                                System.out.println("Before: " + formal);
                                System.out.println("After : " + args[index]);
                            }
                        }
                    }
                }
            }

            System.out.println();
            System.out.println("Final Expanded Code:");

            for (String line : intermediateCode) {
                String[] parts = line.split("\\s+");
                String op = parts[0];

                MNTEntry macro = findMacro(op);
                if (macro != null) {
                    String[] args = Arrays.copyOfRange(parts, 1, parts.length);

                    for (int i = macro.mdtIndex - 1; i < MDT.size(); i++) {
                        String mdtLine = MDT.get(i);
                        if (mdtLine.equals("MEND")) break;
                        String expanded = mdtLine;
                        for (int a = 0; a < args.length; a++) {
                            expanded = expanded.replace("#" + a, args[a]);
                        }
                        System.out.println(expanded);
                    }
                } else {
                    System.out.println(line);
                }
            }
        }

        private MNTEntry findMacro(String name) {
            for (MNTEntry entry : MNT) {
                if (entry.name.equals(name)) {
                    return entry;
                }
            }
            return null;
        }
    }

    public static void main(String[] args) {
        List<MNTEntry> MNT = new ArrayList<>();
        MNT.add(new MNTEntry("INCR", 1));

        List<String> MDT = new ArrayList<>();
        MDT.add("MOVER AREG,#0");
        MDT.add("ADD AREG,ONE");
        MDT.add("MOVEM AREG,#0");
        MDT.add("MEND");

        List<String> IC = Arrays.asList(
            "START 100",
            "READ ALPHA",
            "INCR ALPHA",
            "PRINT ALPHA",
            "END"
        );

        // ALA from Pass1 (formal → positional)
        List<Map<String, String>> ALA = new ArrayList<>();
        Map<String, String> ala1 = new LinkedHashMap<>();
        ala1.put("&X", "#0");
        ALA.add(ala1);

        Pass2 pass2 = new Pass2(MNT, MDT, IC, ALA);
        pass2.expandCode();
    }
}
      


/*


Theory: Pass 2 of Macro Processor

The Pass 2 of the macro processor is responsible for macro expansion — replacing macro calls in the program with their actual sequence of instructions from the MDT (Macro Definition Table).

In this pass:

The MNT (Macro Name Table) is used to locate each macro definition in the MDT.

The ALA (Argument List Array) maps formal parameters to actual arguments used in the macro call.

The MDT provides the macro body, where positional parameters (#0, #1, etc.) are substituted with actual arguments.

The expanded code replaces the macro call in the intermediate code.

Goal: To generate a fully expanded source program ready for the assembler.

⚙️ Algorithm: Pass 2 of Macro Processor

Start.

Read MNT, MDT, ALA, and Intermediate Code (IC) from Pass 1 output.

For each line in the intermediate code:

    - If the line contains a macro name, find its entry in MNT.

    - Retrieve the macro body starting at the corresponding index in MDT.

    - Use ALA to substitute actual arguments for positional parameters (#0, #1, etc.).

    - Write the expanded macro body to the output program.

    - Skip the MEND marker.

    - If the line is not a macro call, copy it directly to the output.

Continue until all lines in intermediate code are processed.

Display the fully expanded program.

Stop.

 */