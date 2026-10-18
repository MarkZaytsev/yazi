use anyhow::Result;
use tokio::task;
use yazi_emulator::EMULATOR;
use yazi_macro::succ;
use yazi_parser::app::StopForm;
use yazi_scheduler::AppProxy;
use yazi_shared::data::Data;
use yazi_tui::{RatermState, STATE};

use crate::{Actor, Ctx};

pub struct Stop;

impl Actor for Stop {
	type Form = StopForm;

	const NAME: &str = "stop";

	fn act(cx: &mut Ctx, Self::Form { alt_screen, replier }: Self::Form) -> Result<Data> {
		if let Some(id) = EMULATOR.probe.pending() {
			task::spawn_local(async move {
				EMULATOR.probe.wait(id).await;
				AppProxy::stop_with(alt_screen, replier);
			});
			succ!();
		}

		cx.active_mut().preview.reset_image();

		if alt_screen {
			STATE.set(RatermState { alt_screen: false, ..STATE.get() });
		}
		*cx.term = None;

		if let Some(replier) = replier {
			replier.send(Ok(Data::Nil)).ok();
		}

		succ!();
	}
}
