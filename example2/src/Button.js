import {MDCRipple} from '@material/ripple';

function init_ripple(element) {
  return new MDCRipple(element);
}

function destroy_ripple(ripple) {
  ripple.destroy();
}