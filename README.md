# 💻 MIPS Assembly Programs Suite

A collection of MIPS assembly programs developed for fundamental algorithm implementation, memory handling, and floating-point operations. This suite includes arithmetic computations, string manipulation, array sorting, and temperature conversion using system calls, stack frames, and register-level logic.

---

## 🏫 Project Information

* **University:** Benha University, Faculty of Engineering (Shoubra)  
* **Department:** Communications and Computer Engineering  
* **Course:** Computer Organization  

---

## 📌 Project Overview

The system includes multiple MIPS programs designed to:

* Handle basic arithmetic and recursive logic (Factorial)
* Work with strings (copying input)
* Sort arrays using bubble sort
* Perform float conversions (Fahrenheit to Celsius)
* Demonstrate stack, register, and memory usage in MIPS

Each program is user-interactive, accepts input via console, and displays outputs using syscall instructions.

---

## 🧠 Programs Included

| Program Name         | Description                                      |
|----------------------|--------------------------------------------------|
| **Leaf Example**     | Computes: `f = (g + h) - (i + j)` with user input |
| **Factorial**        | Recursive calculation of `n!` with user prompt    |
| **Sort**             | Bubble sort for user-entered integer array        |
| **String Copy**      | Copies a user-entered string using loop and stack|
| **Fahrenheit to Celsius** | Converts input temperature using float ops |

---

## ⚙️ Implementation Highlights

### ✅ Leaf Example

* Input: g, h, i, j  
* Formula: `f = (g + h) - (i + j)`  
* Output: Displays computed result f

### ✅ Factorial

* Input: Integer `n`  
* Recursive call stack for `n * (n-1)...1`  
* Output: Displays factorial of n

### ✅ Sort

* Input: Size and array values  
* Logic: Bubble sort  
* Output: Sorted list in ascending order

### ✅ String Copy

* Input: A string  
* Logic: Loop through each character to copy  
* Output: Copied string displayed

### ✅ F to C Conversion

* Input: Fahrenheit temperature  
* Formula: `(F - 32) * 5 / 9`  
* Output: Celsius temperature using float regs

---

## 🧾 How It Works

1. Each program uses syscall-based interaction:
   - `syscall 5/6` for integer/float input
   - `syscall 1/2/4` for result display
2. Registers and memory labels are used for storage.
3. Loops, recursion, and stack frames manage logic and flow.

---

## 📐 Example Execution Flow (Factorial)

1. Prompt: `Enter a number:`  
2. Input: `5`  
3. Process: `5 * 4 * 3 * 2 * 1`  
4. Output: `The factorial of the number is: 120`

---

## 🧪 Testing Results

| Program              | Input Example            | Output Example                  | Status |
|----------------------|--------------------------|----------------------------------|--------|
| Leaf Example         | g=40, h=30, i=20, j=10    | f = 40                           | ✅     |
| Factorial            | 5                        | 120                              | ✅     |
| Sort                 | [3,1,5,2,4]              | [1,2,3,4,5]                      | ✅     |
| String Copy          | "Hello, world!"          | "Hello, world!"                 | ✅     |
| Fahrenheit to Celsius| 68.0                     | 20.0                             | ✅     |

---

## 💾 Source Files

* `Leaf_Example.asm`  
* `Factorial.asm`  
* `Sort.asm`  
* `String_Copy.asm`  
* `F_to_C.asm`  
* `Report.pdf` – Documentation report

---

## 🛠 Tools Used

* **MARS / QtSPIM** – MIPS simulator  
* **Microsoft Word / PDF** – Project documentation  
* **Stack, Memory, Register View** – Debugging and tracing
