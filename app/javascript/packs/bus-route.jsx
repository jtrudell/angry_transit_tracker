import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

import BusStopLink from './bus-stop-link'
import Direction from './direction'

const BusRoute = (props) => {
  const busRoute = props.busRoute
  return (
    <div className="busRoute">
      <h1>Hey there, {busRoute.external_id} - {busRoute.name} bus</h1>

      <p>I travel in these directions:</p>
      <ul>
        {
          busRoute.directions.map((direction) => {
            return <Direction key={direction.id} direction={direction} />
          })
        }
      </ul>

      <p>I make these stops:</p>
      <ul>
        {
          busRoute.bus_stops.map((stop) => {
            return (
              <BusStopLink key={stop.id} linkUrl={"/bus_routes/"+busRoute.id+"/bus_stops/"+stop.id} stop={stop} />
            )
          })
        }
      </ul>
    </div>
  )
}

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('bus_route')
  const data = JSON.parse(node.getAttribute('data'))

  ReactDOM.render(
    <BusRoute busRoute={data}/>,
    document.getElementById('bus_route')
  )
})
