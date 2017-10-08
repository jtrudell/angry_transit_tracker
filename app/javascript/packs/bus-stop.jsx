import React from 'react'

const BusStop = (props) => {
  const stop = props.stop;
  return (
    <li>
      Stop number: {stop.stop_id} - {stop.name} ({stop.direction})
    </li>
  )
}

export default BusStop
