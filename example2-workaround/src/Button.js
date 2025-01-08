import {MDCRipple} from '@material/ripple';

if (!window.Halogen) window.Halogen = {};

window.Halogen.init_ripple = function(element) {
  return new MDCRipple(element);
}

window.Halogen.destroy_ripple = function(ripple) {
  ripple.destroy();
}