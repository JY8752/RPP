import '@riotjs/hot-reload'
import { component, install, register } from 'riot'
import { Route, Router } from '@riotjs/route'
import '@riotjs/observable'
import 'semantic-ui-riot'
import App from './app.riot'
import Store from './store'

install(component => {
  component.store = Store.store

  return component
})

register('router', Router)
register('route', Route)
component(App)(document.getElementById('app'), {
  title: 'Riot Route Demo'
})