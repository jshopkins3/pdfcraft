//! Microsoft 365 host lifecycle. Documents never cross this bridge.
use eframe::wasm_bindgen::{JsCast, JsValue};

fn namespace(name: &str) -> Result<JsValue, String> {
    let window = web_sys::window().ok_or("No browser window")?;
    let sdk = js_sys::Reflect::get(&window, &"microsoftTeams".into()).map_err(|_| "Microsoft 365 library unavailable")?;
    js_sys::Reflect::get(&sdk, &name.into()).map_err(|_| "Microsoft 365 capability unavailable".into())
}

fn call(target: &JsValue, name: &str) -> Result<JsValue, String> {
    let function = js_sys::Reflect::get(target, &name.into())
        .map_err(|_| format!("Microsoft 365 {name} unavailable"))?
        .dyn_into::<js_sys::Function>()
        .map_err(|_| format!("Microsoft 365 {name} unavailable"))?;
    function.call0(target).map_err(|_| format!("Microsoft 365 {name} failed"))
}

pub async fn initialize() -> Result<(), String> {
    let app = namespace("app")?;
    let promise = call(&app, "initialize")?.dyn_into::<js_sys::Promise>().map_err(|_| "Invalid Microsoft 365 initialization")?;
    wasm_bindgen_futures::JsFuture::from(promise).await.map_err(|_| "Could not connect to the Microsoft 365 host")?;
    // Keep Command PDF's document print shortcut. Teams' default print capability
    // intercepts Ctrl/Cmd+P and prints the app window, not its prepared PDF sheets.
    Ok(())
}

pub fn ready() {
    if let Ok(app) = namespace("app") {
        let _ = call(&app, "notifySuccess");
    }
}
