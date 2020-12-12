import '@riotjs/hot-reload'
import { component, register } from 'riot'
import { Router, Route } from '@riotjs/route'
import 'semantic-ui-riot'
import App from './app.riot'
//import './libs'

register('router', Router)
register('route', Route)
component(App)(document.getElementById('app'), {
    title: 'Riot Route Demo'
})