export const requestToServer = async axiosRequestObj => {
  axiosRequestObj.baseURL = "http://localhost:3001/";

  try {
    const resp = await axios(axiosRequestObj);
    if (resp.status === 200) {
      return resp.data;
    } else {
      throw new Error(
        "Server returned error: " +
          resp.status.toString() +
          " " +
          resp.data["error"]
      );
    }
  } catch (e) {
    throw new Error(
      "Server returned error: " +
        e.response.status.toString() +
        " " +
        e.response.data["error"]
    );
  }
};

export const setAuthFn = async obj => {
  await requestToServer({
    url: "/authentication",
    method: "post",
    data: obj
  });
};

export const setUserFn = async obj => {
  await requestToServer({
    url: "/user",
    method: "post",
    data: obj
  });
};

export const getFn = async (obj) => {
  return requestToServer({
    url: '/authentication',
    method: 'get',
    params: obj
  });
};
//const hedgehog = new Hedgehog(getFn, setAuthFn, setUserFn);

/*
export const isLoggedIn = () => hedgehog.isLoggedIn();
export const walletExistsLocally = () =>
  hedgehog && hedgehog.walletExistsLocally && hedgehog.walletExistsLocally();
export const hhlogin = async (userName, password) =>
  await hedgehog.login(userName, password);

export const signUp = async (userName, password) =>
  await hedgehog.signUp(userName, password);

export const hhlogout = () => hedgehog.logout();
export const getAddressString = () => hedgehog.getWallet().getAddressString();
*/