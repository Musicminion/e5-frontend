
let proxyUrl = window.location.protocol;
let hostname = window.location.hostname;

export const environment = {
    production: true,
    // apiUrl: '/api'
    apiUrl: proxyUrl + '//' + hostname + ':8080'
};
