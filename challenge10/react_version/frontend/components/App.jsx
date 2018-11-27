import React from 'react';
import { Route, Switch } from 'react-router';

import BillingContainer from './billing_container';
import NavbarContainer from './navbar_container';
import SessionFormContainer from './session_form_container';

const App = () => (
  <div>
    <NavbarContainer/>
    <BillingContainer/>
  </div>
);

export default App;

// <div>
//     <header>
//       <NavbarContainer/>
//     </header>
//
//     <Switch>
//       <AuthRoute exact path="/signin" component={SessionFormContainer} />
//       <AuthRoute exact path="/signup" component={SessionFormContainer} />
//       <Route path="/discover" component={DiscoverContainer} />
//       <Route path="/search" component={SearchPage} />
//       <ProtectedRoute
//         path="/projects/new"
//         component={ProjectFormContainer}
//       />
//       <ProtectedRoute
//         path="/projects/:projectId/edit"
//         component={ProjectFormContainer}
//       />
//       <ProtectedRoute
//         path="/projects/:projectId/rewards/edit"
//         component={RewardFormContainer}
//       />
//       <Route
//         exact
//         path="/projects/:projectId"
//         component={ProjectShowPageContainer}
//       />
//       <Route path="/" component={HomePageContainer} />
//     </Switch>
//   </div>
