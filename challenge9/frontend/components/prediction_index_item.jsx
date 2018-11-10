import React from 'react';

const getPercentage = number => (
  (100*number).toString()+'%'
);

const getBoundingBoxStyle = prediction => (
  {
    top: getPercentage(prediction.boundingBox.top),
    left: getPercentage(prediction.boundingBox.left),
    width: getPercentage(prediction.boundingBox.width),
    height: getPercentage(prediction.boundingBox.height)
  }
);

const PredictionIndexItem = ({ prediction }) => {
  return (
    <figure
      className="bounding-box"
      style={getBoundingBoxStyle(prediction)}
    >
      <figcaption>
        <header><h3>Scores</h3></header>
        <ul>
          {
            prediction.scores.map((score, idx) => (
              <li key={idx}>
                <span>{score.label}:</span>
                <span>{score.score}</span>
              </li>
            ))
          }
        </ul>
      </figcaption>
    </figure>
  );
};

export default PredictionIndexItem;
