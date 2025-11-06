import java.util.*;

public class MemoryPlacement {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Enter number of memory blocks: ");
        int nb = sc.nextInt();
        int blockSize[] = new int[nb];
        System.out.println("Enter block sizes");
        for(int i=0; i < nb; i++){
            blockSize[i] = sc.nextInt();
        }

        System.out.print("Enter number of processes: ");
        int np = sc.nextInt();
        int processSize[] = new int[np];
        System.out.println("Enter process sizes: ");
        for(int i=0; i < np; i++){
            processSize[i] = sc.nextInt();
        }

        System.out.println("\n1. First Fit\n2. Best Fit\n3. Worst Fit\n4. Next Fit");
        System.out.print("Choose strategy: ");
        int choice = sc.nextInt();

        switch(choice){
            case 1: firstFit(blockSize.clone(), processSize); break;
            case 2: bestFit(blockSize.clone(), processSize); break;
            case 3: worstFit(blockSize.clone(), processSize); break;
            case 4: nextFit(blockSize.clone(), processSize); break;
            default: System.out.println("Invalid choice!");
        }
    }

    static void firstFit(int blockSize[], int processSize[]){
        int allocation[] = new int[processSize.length];
        Arrays.fill(allocation, -1);

        for(int i=0; i<processSize.length; i++){
            for(int j=0; j<blockSize.length; j++){
                if(blockSize[j] >= processSize[i]){
                    allocation[i] = j;
                    blockSize[j] -= processSize[i];
                    break;
                }
            }
        }
        printAllocation(allocation, processSize);
    }

    static void bestFit(int blockSize[], int processSize[]){
        int allocation[] = new int[processSize.length];
        Arrays.fill(allocation, -1);

        for(int i=0; i<processSize.length; i++){
            int bestIdx = -1;
            for(int j=0; j<blockSize.length; j++){
                if(blockSize[j] >= processSize[i]){
                    if(bestIdx == -1 || blockSize[j] < blockSize[bestIdx]){
                        bestIdx = j;
                    }
                }
            }
            if(bestIdx != -1){
                allocation[i] = bestIdx;
                blockSize[bestIdx] -= processSize[i];
            }
        }
        printAllocation(allocation, processSize);
    }

    static void worstFit(int blockSize[], int processSize[]){
        int allocation[] = new int[processSize.length];
        Arrays.fill(allocation, -1);

        for(int i=0; i<processSize.length; i++){
            int worstIdx = -1;
            for(int j=0; j<blockSize.length; j++){
                if(blockSize[j] >= processSize[i]){
                    if(worstIdx == -1 || blockSize[j] > blockSize[worstIdx]){
                        worstIdx = j;
                    }
                }
            }
            if(worstIdx != -1){
                allocation[i] = worstIdx;
                blockSize[worstIdx] -= processSize[i];
            }
        }
        printAllocation(allocation, processSize);
    }

    static void nextFit(int blockSize[], int processSize[]){
        int allocation[] = new int[processSize.length];
        Arrays.fill(allocation, -1);
        int j = 0;

        for(int i=0; i<processSize.length; i++){
            int count = 0;
            while(count < blockSize.length){
                if(blockSize[j] >= processSize[i]){
                    allocation[i] = j;
                    blockSize[j] -= processSize[i];
                    break;
                }
                j = (j + 1) % blockSize.length;
                count++;
            }
        }
        printAllocation(allocation, processSize);
    }

    static void printAllocation(int allocation[], int processSize[]) {
        System.out.println("\nProcess No.\tProcess Size\tBlock No.");
        for (int i = 0; i < processSize.length; i++) {
            System.out.print("   " + (i + 1) + "\t\t" + processSize[i] + "\t\t");
            if (allocation[i] != -1)
                System.out.println(allocation[i] + 1);
            else
                System.out.println("Not Allocated");
        }
    }
}




/*

🧠 Theory: Memory Placement Strategies

When multiple processes request memory, the operating system must decide where to place each process in the available memory blocks.
The goal is to reduce internal and external fragmentation and improve memory utilization.

The four main strategies are:

First Fit – Allocate the first available block that is large enough.

Best Fit – Allocate the smallest available block that fits the process.

Worst Fit – Allocate the largest available block to reduce fragmentation.

Next Fit – Similar to First Fit, but continues searching from where the last allocation left off.

⚙️ 1. First Fit
Algorithm

Start.

Input number of memory blocks and their sizes.

Input number of processes and their sizes.

For each process:

    - Scan blocks from the beginning.

    - Allocate the first block that fits.

    - Reduce that block’s size.

If no suitable block is found, mark process as “Not Allocated”.

Display allocation table.

Stop.

🧩 2. Best Fit
Algorithm

Start.

Input memory block and process sizes.

For each process:

    - Find the block with the minimum leftover space that can fit the process.

    - Allocate that block and reduce its size.

If no suitable block exists, mark as “Not Allocated”.

Display allocation table.

Stop.

💡 3. Worst Fit
Algorithm

Start.

Input memory block and process sizes.

For each process:

    - Find the block with the maximum leftover space that can fit the process.

    - Allocate that block and reduce its size.

If no suitable block exists, mark as “Not Allocated”.

Display allocation table.

Stop.


🔁 4. Next Fit
Algorithm

Start.

Input block and process sizes.

Maintain a pointer to the last allocated block.

For each process:

    - Start searching from the last position.

    - Allocate the first block found that fits.

    - Update the pointer for the next search.

If no block fits, mark as “Not Allocated”.

Display allocation table.

Stop.


 */