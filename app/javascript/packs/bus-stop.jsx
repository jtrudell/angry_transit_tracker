import React from 'react'
import ReactDOM from 'react-dom'

import capitalize from './utils/capitalize'

const BusStop = props => {
  const { predictions, routeName } = props.busStop
  return (
    <div>
      <h1>
        Hey there, {routeName} bus stop
      </h1>
      {
        Object.keys(predictions).map((predictionKey) => {
          return (
            <p key={routeName+"-"+predictionKey}>
              {capitalize(predictionKey)}: {predictions[predictionKey]}
            </p>
          )
        })
      }
    </div>
  )
}

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('app')
  const data = JSON.parse(node.getAttribute('data'))

  ReactDOM.render(
    <BusStop busStop={data}/>,
    document.getElementById('app')
  )
})
