# DATA-2955: Add Credit Applications to Intercom Explore

This branch contains LookML files to join `dim_credit_application` into the **Intercom Conversations Explore**, enabling direct filtering between `submitted_at` (credit application) and `created_at` (Intercom conversation).

## Files

| File | Purpose |
|------|---------|
| `views/credit_application/base/base_dim_credit_application.view.lkml` | Base view mapping to `dw-prod-gwiiag.dbt.dim_credit_application` |
| `views/credit_application/standard/dim_credit_application.view.lkml` | Standard view extending base with labels, descriptions, and measures |
| `explores/intercom_conversations_credit_application_join.lkml` | Join snippet reference for the Intercom Conversations explore |

## How to Apply in `dt-lookml`

### 1. Copy View Files

Copy the two view files into the `dt-lookml` repository:

```
dt-lookml/
  views/
    credit_application/
      base/
        base_dim_credit_application.view.lkml
      standard/
        dim_credit_application.view.lkml
```

### 2. Include the View in the Intercom Model

Add this include statement at the top of the Intercom model file (e.g., `intercom.model.lkml`):

```lookml
include: "/views/credit_application/standard/dim_credit_application.view.lkml"
```

### 3. Add the Join to the Intercom Conversations Explore

Inside the existing `explore: intercom_conversations { ... }` block, add:

```lookml
join: dim_credit_application {
  type: left_outer
  relationship: many_to_one
  sql_on: ${intercom_conversations.user_id} = ${dim_credit_application.user_id} ;;
}
```

### 4. Validate and Deploy

- Run LookML validation in Looker to confirm no errors
- Verify that the "Credit Application" view label appears in the Intercom Conversations Explore
- Test filtering: `intercom_conversations.created_at > dim_credit_application.submitted_at`

## Join Details

- **Join type:** `left_outer` (all Intercom conversations are preserved; credit application data is added when available)
- **Relationship:** `many_to_one` (many conversations can map to one user's credit application)
- **Join key:** `user_id` on both sides
- **Source table:** `dw-prod-gwiiag.dbt.dim_credit_application`
