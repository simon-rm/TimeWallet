import { application } from "controllers/application"
import { UltimateTurboModalController } from "ultimate_turbo_modal"
application.register("modal", UltimateTurboModalController)
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)
