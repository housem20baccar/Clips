# Professor Knowledge Management System

A CLIPS-based expert system for managing professor course assignments and knowledge relationships. This system allows users to track professors, their courses, and automatically generate knowledge relationships between professors and course sections.

## Overview

This system maintains a knowledge base of professors and their course assignments, using CLIPS (C Language Integrated Production System) rules and templates to manage the relationships between professors and courses. It provides a message-based interface for interacting with the system and performing various operations.

## Features

- Add and manage professor information including name, course code, and class
- Track course coverage assignments
- Automatically generate knowledge relationships between professors and subjects
- List all registered courses, professors, and knowledge relationships
- Remove course coverage assignments

## System Components

### Templates

- `professor`: Stores professor information (name, course-code, class)
- `cover`: Records course coverage assignments (course, section)
- `know`: Represents knowledge relationships between professors and subjects
- `message`: Handles system commands and parameters

### Available Commands

1. **Add Professor** (Code 1)
   ```clips
   (assert (message (code 1) (parameters "name course-code class")))
   ```

2. **Add Course Coverage** (Code 2)
   ```clips
   (assert (message (code 2) (parameters "course section")))
   ```

3. **Generate Knowledge Facts** (Code 3)
   ```clips
   (assert (message (code 3) (parameters "")))
   ```

4. **Remove Course Coverage** (Code 4)
   ```clips
   (assert (message (code 4) (parameters "course")))
   ```

5. **List All Courses** (Code 5)
   ```clips
   (assert (message (code 5) (parameters "")))
   ```

6. **List All Professors** (Code 6)
   ```clips
   (assert (message (code 6) (parameters "")))
   ```

7. **List Knowledge Facts** (Code 7)
   ```clips
   (assert (message (code 7) (parameters "")))
   ```

## Example Usage

To add a professor:
```clips
(assert (message (code 1) (parameters "Dr. Smith COMP101 A1")))
```

To add course coverage:
```clips
(assert (message (code 2) (parameters "COMP101 Algorithms")))
```

## System Rules

The system includes several key rules:

- `process-message`: Handles all incoming command messages
- `knows`: Automatically generates knowledge relationships between professors and subjects
- `startup`: Initializes the system and displays available commands

## Note

The system automatically maintains consistency between professor assignments and knowledge relationships. When a professor is assigned to a course, the system will automatically generate the corresponding knowledge facts based on the course sections they cover.
![Screenshot 2024-12-26 212823](https://github.com/user-attachments/assets/90a3ff3c-c1f9-4c86-b2ca-c41ddd3f4d2b)
![Screenshot 2024-12-26 212733](https://github.com/user-attachments/assets/1cd4a5f8-65bf-46da-9c4e-499bd37e63c5)
![Screenshot 2024-12-26 212640](https://github.com/user-attachments/assets/daa1aa99-d8f6-4815-a46e-ca9f669adfc1)


