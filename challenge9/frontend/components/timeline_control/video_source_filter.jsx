import React from 'react';

const VideoSourceFilter = ({ labels }) => {
  return (
    <li>
      <label htmlFor="video-source">Video Source</label>
      <select id="video-source">
        <option defaultValue="" disabled>Select your option</option>
        {
          labels.map((label, idx) => (
            <option key={idx} value={label}>{label}</option>
          ))
        }
      </select>
    </li>
  );
};

export default VideoSourceFilter;

// react-dom.development.js:506 Warning: Use the `defaultValue` or `value` props on <select> instead of setting `selected` on <option>.
