import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

const BusRoute = props => (
  <div className="busRoute">
    <h1>Hey there, {props.busRoute.external_id} - {props.busRoute.name} bus</h1>

    <p>I travel in these directions:</p>
    <ul>
      {
        props.busRoute.directions.map((direction) => {
          return <li key={direction.id}>{direction.direction}</li>
        })
      }
    </ul>

    <p>I make these stops:</p>
    <ul>
      {
        props.busRoute.bus_stops.map((stop) => {
          return (
            <li key={stop.id}>
              Stop number: {stop.stop_id} - {stop.name} ({stop.direction})
            </li>
          )
        })
      }
    </ul>
  </div>
)

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('bus_route')
  const data = JSON.parse(node.getAttribute('data'))

  ReactDOM.render(
    <BusRoute busRoute={data}/>,
    document.getElementById('bus_route')
  )
})
