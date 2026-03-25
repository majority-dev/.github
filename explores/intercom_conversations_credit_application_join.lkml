# Join snippet for dim_credit_application in the Intercom Conversations Explore
#
# Add this join block inside the existing `explore: intercom_conversations { ... }`
# definition in the Intercom model file (e.g., intercom.model.lkml).
#
# Also ensure the view file is included at the top of the model:
#   include: "/views/credit_application/standard/dim_credit_application.view.lkml"
#
# Example:
#
#   explore: intercom_conversations {
#     ...existing configuration...
#
#     join: dim_credit_application {
#       type: left_outer
#       relationship: many_to_one
#       sql_on: ${intercom_conversations.user_id} = ${dim_credit_application.user_id} ;;
#     }
#   }
