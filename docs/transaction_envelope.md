# Transaction Envelope

Options:
*  `:interchange_sender_id_qualifier`, default: `:mutually_defined`
*  `:interchange_sender_id`
*  `:interchange_receiver_id_qualifier`, default: `:mutually_defined`
*  `:interchange_receiver_id`
*  `:functional_groups`, default: `[]`
*  `:interchange_control_number`,
*  `:date_time`, default: `DateTime.now`
*  `:repetition_separator`, default: `?^`
*  `:component_element_separator`, default: `?:`
*  `:interchange_usage_indicator`, default: `:production`
*  `:authorization_information_qualifier`, default: `:no_authorization_information_present`
*  `:authorization_information`, default: `          ` (10 whitespaces)
*  `:security_information_qualifier`, default: `:no_security_information_present`
*  `:security_information`, default: `          ` (10 whitespaces)
*  `acknowledgement_requested`, default: `false`
