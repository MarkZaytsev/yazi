use crate::RatermOption;

#[derive(Clone, Copy)]
pub struct RatermState {
	pub mouse:      bool,
	pub title:      bool,
	pub alt_screen: bool,
	pub started:    bool,
}

impl RatermState {
	pub(super) const fn default() -> Self {
		Self { mouse: false, title: false, alt_screen: false, started: false }
	}

	pub(super) fn new(opt: &RatermOption) -> Self {
		Self { mouse: opt.mouse, alt_screen: true, started: true, ..Self::default() }
	}
}
