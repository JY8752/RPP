import '@riotjs/hot-reload'
import { component, register, install } from 'riot'
import { Router, Route } from '@riotjs/route'
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