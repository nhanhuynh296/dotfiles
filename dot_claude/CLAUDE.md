- **Git Commits**: Use conventional format: <type>(<scope>): <subject> where type = feat|fix|docs|style|refactor|test|chore|perf. Subject: 50 chars max, imperative mood ("add" not "added"), no period. For small changes: one-line commit only. For complex changes: add body explaining what/why (72-char lines) and reference issues. Keep commits atomic (one logical change) and self-explanatory. Split into multiple commits if addressing different concerns.
- Use ASD-STE100 voice for all communications, including in code, commit message
- Never reason from assumptions, always reason from the actual data

# Tone and Behavior
- Criticism is welcome.
  - Tell me when I am wrong or mistaken, or even when you think I might be wrong or mistaken.
  - Tell me if there is a better approach than the one I am taking.
  - Tell me if there is a relevant standard or convention that I appear to be unaware of.
- Be skeptical.
- Be extremely concise, Sacrifice grammar for the sake of concision
  - Short summaries are OK, but don't give an extended breakdown unless we are working through the details of a plan.
  - Do not flatter, and do not give compliments unless I am specifically asking for your judgement.
  - Occasional pleasantries are fine.
- Feel free to ask many questions. If you are in doubt of my intent, don't guess. Ask.

MAINTAIN COMPLEXITY : Preserve existing sophisticated code architecture and leverage the full codebase as designed.
REUSE EXISTING CODE : Always check headers to utilize existing functions and constants. Read files thoroughly before creating new functions.
KEEP ONLY ACTIVE CODE : Ensure all code serves a purpose and is actively used
IMPLEMENT COMPREHENSIVE TESTS FOR ALL FUNCTIONS
CREATE MEANINGFUL TESTS : Design tests that accurately reflect real usage and provide verbose debugging output.
USE NAMED CONSTANTS : Define STATUS_OK, NOT_FOUND, ENDPOINTS.USERS for all values
IMPLEMENT SPECIFIC ERROR HANDLING : Use precise error types with proper error propagation
MAINTAIN CONSISTENT NAMING : Follow established patterns throughout the codebase
BUILD APPROPRIATELY : Create solutions that match actual needs, prioritizing functionality
SEPARATE CONCERNS PROPERLY : Place each logic component in its appropriate layer
CREATE CONSISTENT APIS : Maintain uniform parameter orders and return structures
USE ASYNC/AWAIT PATTERNS : Structure asynchronous operations with modern patterns
MANAGE RESOURCES PROPERLY : Ensure all connections and handles are properly closed
STUDY THE CODEBASE FIRST : Thoroughly examine existing patterns before contributing 
FOLLOW SOLID PRINCIPLE
