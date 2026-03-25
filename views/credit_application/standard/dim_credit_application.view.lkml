include: "../base/base_dim_credit_application.view.lkml"

view: dim_credit_application {
  extends: [base_dim_credit_application]
  view_label: "Credit Application"

  dimension: credit_application_id {
    label: "Credit Application ID"
    description: "Unique identifier for the credit application"
  }

  dimension: user_id {
    label: "User ID"
    description: "The user who submitted the credit application"
  }

  dimension: status {
    label: "Application Status"
    description: "Current status of the credit application"
  }

  dimension_group: submitted_at {
    label: "Submitted"
    description: "Timestamp when the credit application was submitted"
  }

  dimension_group: created_at {
    label: "Created"
    description: "Timestamp when the credit application record was created"
  }

  dimension_group: updated_at {
    label: "Updated"
    description: "Timestamp when the credit application record was last updated"
  }

  measure: count {
    type: count
    label: "Count of Credit Applications"
    description: "Total number of credit applications"
  }

  measure: count_distinct_users {
    type: count_distinct
    sql: ${user_id} ;;
    label: "Distinct Users with Credit Applications"
    description: "Number of distinct users who submitted credit applications"
  }
}
