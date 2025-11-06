import java.util.*;

public class CPUScheduling {
    static class Process {
        int pid, at, bt, rt, wt, tat, priority;
        Process(int pid, int at, int bt, int priority) {
            this.pid = pid;
            this.at = at;
            this.bt = bt;
            this.rt = bt;
            this.priority = priority;
        }
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter number of processes: ");
        int n = sc.nextInt();
        Process p[] = new Process[n];

        for (int i = 0; i < n; i++) {
            System.out.println("Enter Arrival Time, Burst Time and Priority for P" + (i + 1) + ":");
            int at = sc.nextInt();
            int bt = sc.nextInt();
            int pr = sc.nextInt();
            p[i] = new Process(i + 1, at, bt, pr);
        }

        System.out.println("\n1. FCFS\n2. SJF (Preemptive)\n3. Priority (Non-Preemptive)\n4. Round Robin");
        System.out.print("Choose algorithm: ");
        int choice = sc.nextInt();

        switch (choice) {
            case 1: fcfs(p); break;
            case 2: sjfPreemptive(p); break;
            case 3: priorityNonPreemptive(p); break;
            case 4:
                System.out.print("Enter time quantum: ");
                int tq = sc.nextInt();
                roundRobin(p, tq);
                break;
            default: System.out.println("Invalid choice!");
        }
    }

    // ---------- FCFS ----------
    static void fcfs(Process p[]) {
        Arrays.sort(p, Comparator.comparingInt(a -> a.at));
        int time = 0;
        for (Process pr : p) {
            if (time < pr.at) time = pr.at;
            pr.wt = time - pr.at;
            time += pr.bt;
            pr.tat = pr.wt + pr.bt;
        }
        printResult(p, "FCFS");
    }

    // ---------- SJF (Preemptive) ----------
    static void sjfPreemptive(Process p[]) {
        int n = p.length;
        int completed = 0, time = 0, minRt, shortest = -1;
        boolean check;
        while (completed != n) {
            minRt = Integer.MAX_VALUE;
            check = false;
            for (int i = 0; i < n; i++) {
                if (p[i].at <= time && p[i].rt > 0 && p[i].rt < minRt) {
                    minRt = p[i].rt;
                    shortest = i;
                    check = true;
                }
            }
            if (!check) {
                time++;
                continue;
            }
            p[shortest].rt--;
            if (p[shortest].rt == 0) {
                completed++;
                int finish = time + 1;
                p[shortest].tat = finish - p[shortest].at;
                p[shortest].wt = p[shortest].tat - p[shortest].bt;
            }
            time++;
        }
        printResult(p, "SJF (Preemptive)");
    }

    // ---------- Priority (Non-Preemptive) ----------
    static void priorityNonPreemptive(Process p[]) {
        Arrays.sort(p, Comparator.comparingInt(a -> a.at));
        int time = 0, completed = 0;
        boolean[] done = new boolean[p.length];

        while (completed != p.length) {
            int idx = -1, highest = Integer.MAX_VALUE;
            for (int i = 0; i < p.length; i++) {
                if (!done[i] && p[i].at <= time) {
                    if (p[i].priority < highest) {
                        highest = p[i].priority;
                        idx = i;
                    }
                }
            }
            if (idx == -1) {
                time++;
                continue;
            }
            done[idx] = true;
            p[idx].wt = time - p[idx].at;
            time += p[idx].bt;
            p[idx].tat = p[idx].wt + p[idx].bt;
            completed++;
        }
        printResult(p, "Priority (Non-Preemptive)");
    }

    // ---------- Round Robin (Preemptive) ----------
    static void roundRobin(Process p[], int tq) {
        Queue<Process> q = new LinkedList<>();
        int time = 0, completed = 0;
        Arrays.sort(p, Comparator.comparingInt(a -> a.at));
        q.add(p[0]);
        int idx = 1;

        while (!q.isEmpty()) {
            Process cur = q.poll();
            if (time < cur.at) time = cur.at;

            int exec = Math.min(cur.rt, tq);
            cur.rt -= exec;
            time += exec;

            // Add processes that have arrived
            while (idx < p.length && p[idx].at <= time) q.add(p[idx++]);

            if (cur.rt > 0)
                q.add(cur);
            else {
                completed++;
                cur.tat = time - cur.at;
                cur.wt = cur.tat - cur.bt;
            }
        }
        printResult(p, "Round Robin");
    }

    // ---------- Print ----------
    static void printResult(Process p[], String algo) {
        System.out.println("\n" + algo + " Scheduling Result:");
        System.out.println("PID\tAT\tBT\tPri\tWT\tTAT");
        float totalWT = 0, totalTAT = 0;
        for (Process pr : p) {
            System.out.println(pr.pid + "\t" + pr.at + "\t" + pr.bt + "\t" + pr.priority + "\t" + pr.wt + "\t" + pr.tat);
            totalWT += pr.wt;
            totalTAT += pr.tat;
        }
        System.out.printf("Average Waiting Time = %.2f\n", totalWT / p.length);
        System.out.printf("Average Turnaround Time = %.2f\n", totalTAT / p.length);
    }
}


/*

🧠 Theory

CPU Scheduling is the process of deciding which process will use the CPU next when multiple processes are waiting. The aim is to maximize CPU utilization and minimize waiting and turnaround times.

This program implements four CPU scheduling algorithms:

First Come First Serve (FCFS) – Processes are executed in the order they arrive.

Shortest Job First (SJF – Preemptive) – The process with the smallest remaining burst time runs next.

Priority Scheduling (Non-Preemptive) – The process with the highest priority (lowest number) runs first.

Round Robin (RR) – Each process gets a fixed time quantum. If unfinished, it’s placed at the end of the queue.

Key Terms:

Arrival Time (AT) – Time when the process enters the ready queue.

Burst Time (BT) – Total CPU time required by the process.

Waiting Time (WT) – Time spent waiting in the ready queue.

Turnaround Time (TAT) – Total time from arrival to completion (TAT = WT + BT).

⚙️ Algorithm

🧩 1. FCFS (First Come First Serve)
Algorithm

Start.

Input number of processes and their Arrival Time (AT) and Burst Time (BT).

Sort all processes in increasing order of Arrival Time.

For each process:

    - Calculate Waiting Time (WT) = (Start Time − Arrival Time).

    - Calculate Turnaround Time (TAT) = WT + BT.

Compute average WT and TAT.

Display results.

Stop.

⚙️ 2. SJF (Shortest Job First – Preemptive)
Algorithm

Start.

Input number of processes and their Arrival Time (AT) and Burst Time (BT).

Initialize current time = 0 and remaining time = BT for all processes.

While all processes are not completed:

    - Select the process with the shortest remaining time among those that have arrived.

    - Execute it for 1 time unit.

    - Update remaining time and current time.

    - If a process finishes, calculate WT and TAT.

Compute average WT and TAT.

Display results.

Stop.

🧠 3. Priority Scheduling (Non-Preemptive)
Algorithm

Start.

Input number of processes and their Arrival Time (AT), Burst Time (BT), and Priority.

Initialize current time = 0.

While all processes are not completed:

    - From the processes that have arrived, select the one with the highest priority (lowest priority number).

    - Execute it completely.

    - Calculate WT = Start Time − Arrival Time.

    - Calculate TAT = WT + BT.

Compute average WT and TAT.

Display results.

Stop.

🔁 4. Round Robin Scheduling
Algorithm

Start.

Input number of processes and their Arrival Time (AT) and Burst Time (BT).

Input Time Quantum (TQ).

Initialize ready queue and current time = 0.

While ready queue is not empty:

    - Select the first process in queue.

    - Execute it for min(Remaining Time, TQ).

    - Update current time and remaining time.

    - If the process is not finished, re-add it to the queue.

    - If finished, calculate WT and TAT.

Compute average WT and TAT.

Display results.

Stop.

 */