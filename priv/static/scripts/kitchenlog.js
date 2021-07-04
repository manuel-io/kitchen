export default class KitchenLog {
  constructor(csrf_token) {
    this.csrf_token = csrf_token;
  }

  login(form, start, ready, fail) {
    if (start) start(form);
  }

  open(action, method, form, ready, fail) {
    fetch(action, { method: method
                  , headers: { 'x-csrf-token': this.csrf_token }
                  }).then(response => {

        if (!response.ok) { throw Error(response.text()); }
        else { return response.text(); }

    }).then(data => ready(data)).catch(data => fail(data));
  }
};
