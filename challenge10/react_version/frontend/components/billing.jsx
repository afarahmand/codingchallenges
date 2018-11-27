import React from 'react';
import BalancePayment from './billing/balance_payment';
// import { Link } from 'react-router-dom';

class Billing extends React.Component {
  componentDidMount() {
    this.props.fetchOrganization(this.props.currentUser.organizationId);
  }

  displayAmount(refunded, amount) {
    if (refunded) return (<span className="text-green">(${amount})</span>);
    return (<span>${amount}</span>);
  }

  displayDate(date) {
    return (<td>{date.slice(5,7)}/{date.slice(8,10)}/{date.slice(0,4)}</td>);
  }

  displayDocuments() {

  }



  render() {
    if (this.props.organization === null) return null;

    const { organization } = this.props;
    const { items } = this.props.organization;

    return (
      <main>

        <section id="balance-payment-search" className="content-narrow">
          <BalancePayment
            balance={organization.balance}
            paymentMethods={organization.paymentMethods}
          />

          <div id="search-container">
            <input
              type="text" name="" placeholder="Search your shipments">
            </input>
            <i className="fas fa-search"></i>
          </div>

        </section>

        <hr></hr>

        <section id="shipment-table">
          <table>
            <thead>
              <tr className="background-light-gray">
                <th>Date</th>
                <th>Shipment</th>
                <th>Location</th>
                <th></th>
                <th>Reference</th>
                <th>Amount</th>
                <th>Documents</th>
              </tr>
            </thead>

            <tbody>
            {
              Object.keys(items).map(id =>
              (
              <tr key={id}>
                {this.displayDate(items[id].date)}
                <td>
                  {items[id].shipmentReferenceNumber}
                </td>
                <td>
                  <span>
                    {items[id].pickupLocation.name}
                  </span>
                  <span className="city-state-zip">
                    {items[id].pickupLocation.city}, {items[id].pickupLocation.state} {items[id].pickupLocation.zip}
                  </span>
                </td>
                <td>
                  <span>
                    {items[id].deliveryLocation.name}
                  </span>
                  <span className="city-state-zip">
                    {items[id].deliveryLocation.city}, {items[id].deliveryLocation.state} {items[id].deliveryLocation.zip}
                  </span>
                </td>
                <td>
                  {items[id].referenceNumber}
                </td>
                <td>
                  {this.displayAmount(items[id].refunded, items[id].amount)}
                </td>
                <td>
                  {this.displayDocuments()}
                  <span className="text-blue">View Docs</span>
                  <i className="fas fa-angle-down">
                    <div className="drop-down-window speech-bubble">
                      <ul>
                        <li>BOL/POD</li>
                        <li>Invoice</li>
                      </ul>
                    </div>
                  </i>
                </td>
              </tr>
              ))
            }
            </tbody>
          </table>
        </section>
      </main>
    );
  }
}

export default Billing;


// <tr>
//   <td>03/21/2018</td>
//   <td>XHSKW1</td>
//   <td>
//     <span>Bella Canvas West Cost Warehouse</span>
//     <span className="city-state-zip">Commerce, CA 90310</span>
//   </td>
//   <td>
//     <span>
//       Melmarc International Dock 238 and some more clipped tex
//     </span>
//     <span className="city-state-zip">Santa Ana, CA 92653</span>
//   </td>
//   <td>PO-2736723, SO-372679959XXXXXXX</td>
//   <td>$547.93</td>
//   <td>
//     <span className="text-blue">View Docs</span>
//     <i className="fas fa-angle-down">
//       <div className="drop-down-window speech-bubble">
//         <ul>
//           <li>BOL/POD</li>
//           <li>Invoice</li>
//         </ul>
//       </div>
//     </i>
//   </td>
// </tr>
//
// <tr>
//   <td>03/21/2018</td>
//   <td>DUW2Q9</td>
//   <td>
//     <span>AS Color</span>
//     <span className="city-state-zip">
//       Santa Fe Springs, CA 90710
//     </span>
//   </td>
//   <td>
//     <span>Beimar</span>
//     <span className="city-state-zip">Ontario, CA 91763</span>
//   </td>
//   <td>LA Gear Pumps 12</td>
//   <td><span className="text-green">($67.13)</span></td>
//   <td>
//     <span className="text-blue">View Docs</span>
//     <i className="fas fa-angle-down">
//       <div className="drop-down-window speech-bubble">
//         <ul>
//           <li>BOL/POD</li>
//           <li>Invoice</li>
//         </ul>
//       </div>
//     </i>
//   </td>
// </tr>
