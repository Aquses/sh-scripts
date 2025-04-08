#!/bin/bash

STUDENT_NAME=$1
ASSIGNMENT_PATH="registered-students/$STUDENT_NAME/assignment1"
GRADE_REPORT_PATH="grades-reported/$STUDENT_NAME"

ln "$ASSIGNMENT_PATH" "$GRADE_REPORT_PATH" 2>/dev/null

# chmod 0400 "$GRADE_REPORT_PATH" 2>/dev/null

chmod 0444 "$ASSIGNMENT_PATH" 2>/dev/null

echo "Succesfully reported grade! Student: $STUDENT_NAME, Grade: $(cat "$ASSIGNMENT_PATH")"
