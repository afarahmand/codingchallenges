import React from 'react';

class BalancePayment extends React.Component {
  constructor(props) {
    super(props);

    // this.state = this.props.paymentMethods;
  }

  displayBalance(balance) {
    return (
      <span className="balance">Your Balance: ${balance.toFixed(2)}</span>
    );
  }

  render() {
    const { bankAccounts, cards } = this.props.paymentMethods;

    let selectedPM = bankAccounts.concat(cards).filter(pm => (pm.isDefault))[0];
    let otherPMs = bankAccounts.concat(cards).filter(pm => (!pm.isDefault));

    return (
      <div>
        {this.displayBalance(this.props.balance)}
        <div className="payment-method text-blue">


          <span>Payment Method - {selectedPM.brand} *{selectedPM.last4}</span>
          <div>
            <i className="fas fa-angle-down">
              <div className="drop-down-window speech-bubble">
                <ul>
                  {
                    otherPMs.map((pm, idx) => (
                      <li key={idx}>
                        <input
                          defaultValue={`${pm.brand} *${pm.last4}`}
                          id={`payment-source-${idx}`}
                          name="payment-source"
                          type="radio"
                        >
                        </input>
                        <label htmlFor={`payment-source-${idx}`}>
                          {pm.brand} *{pm.last4}
                        </label>
                      </li>
                    ))
                  }
                </ul>

                <button type="button" name="button">
                  <i className="fas fa-plus-circle"></i>
                  Add Payment Source
                </button>
              </div>
            </i>
          </div>
        </div>
      </div>
    );
  }
}

export default BalancePayment;
