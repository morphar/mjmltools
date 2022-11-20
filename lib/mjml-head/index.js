import { HeadComponent } from '../mjml-core/index.js'

export default class MjHead extends HeadComponent {
  static componentName = 'mj-head'

  handler() {
    return this.handlerChildren()
  }
}
