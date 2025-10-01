import { application } from "./application"

// Import and register controllers
import AccordionController from "./accordion_controller"
import ContactsFormController from "./contacts_form_controller"

application.register("accordion", AccordionController)
application.register("contacts-form", ContactsFormController)