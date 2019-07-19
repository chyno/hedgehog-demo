import { hedgehog } from "./hedgehog.js";

let app = Elm.Main.init({
  flags: "Hello",
  node: document.getElementById("elm")
});

app.ports.loginUser.subscribe(function(data) {
  app.ports.loginResult.send({
    address: "12345",
    isLoggedIn: true,
    message: 'success'
  });
  // hedgehog.login(data.userName, data.password).then(
  //   () => {
  //     app.ports.loginResult.send({
  //       address: hedgehog.getWallet().getAddressString(),
  //       isLoggedIn: isLoggedIn(),
  //       message: "Success"
  //     });
  //   },
  //   e => {
  //     app.ports.loginResult.send({
  //       address: "",
  //       isLoggedIn: false,
  //       message: e.message
  //     });
  //   }
  // );
});

app.ports.logoutUser.subscribe(function() {
  hedgehog.logout();
  console.log("user logged out");
  app.ports.loginResult.send({
    address: "",
    isLoggedIn: false,
    message: "User Logged out"
  });
});
app.ports.registerUser.subscribe(function(data) {
  hedgehog.logout();
  hedgehog.signUp(data.userName, data.password).then(
    () => {
      app.ports.loginResult.send({
        address: "",
        isLoggedIn: false,
        message: "User Created"
      });
    },
    e => {
      app.ports.loginResult.send({
        address: "",
        isLoggedIn: false,
        message: e.message
      });
    }
  );
});

function isLoggedIn() {
  if (hedgehog.isLoggedIn()) {
    return true;
  } else {
    return (
      hedgehog && hedgehog.walletExistsLocally && hedgehog.walletExistsLocally()
    );
  }
}
