import React from 'react'

const BusStopLink = props => {
  const { linkUrl, stop } = props
  return (
    <li>
      <a href={linkUrl}>
        Stop number: {stop.stop_id} - {stop.name} ({stop.direction})
      </a>
    </li>
  )
}

export default BusStopLink
