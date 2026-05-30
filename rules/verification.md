# Verification Rules

## Prove It Works
- Never claim a task is done without running the code and observing the output.
- "Type-checks pass" and "tests pass" verify *correctness*, not *behavior*. UI/feature correctness requires actually exercising the feature.
- If you cannot run/test (no env, no data, no UI), say so explicitly. Don't claim success from reading the diff.

## Data Pipelines
- Print `df.shape`, `df.dtypes`, `df.head()` after every non-trivial transform during initial development.
- Diff behavior between original and modified code on the same input when refactoring.

## Senior-Engineer Gate
- Before presenting work, ask: *would a senior engineer in this domain approve this?*
- If the answer is no or uncertain, fix it before showing the user.

## Writer/Reviewer for High-Stakes Code
- Any backtest, financial model, or analysis that could mislead → mandatory Writer/Reviewer pattern.
  - Writer session implements the model.
  - Reviewer session reads the code with a hostile prior and checks for: lookahead bias, return-calc errors, survivorship bias, transaction-cost omission, dtype mismatches that silently change semantics.
- The reviewer is not the writer with a checklist — it's a separate run that assumes the writer is wrong.

## UI/Frontend
- Start the dev server. Open the page. Click the thing.
- Check the golden path AND likely edge cases.
- Watch for regressions in adjacent features, not just the one you touched.
