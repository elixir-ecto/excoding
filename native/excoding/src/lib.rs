#[macro_use]
extern crate rustler;
extern crate encoding;
extern crate lazy_static;
extern crate rustler_codegen;

use encoding::label::encoding_from_whatwg_label;
use encoding::{DecoderTrap, EncoderTrap};

use rustler::types::binary::{Binary, OwnedBinary};
use rustler::Error;
use rustler::{Encoder, Env, NifResult, Term};

use std::io::Write;

mod atoms {
    atoms! {
        ok,
        error,
        unknown_encoding,
        //atom __true__ = "true";
        //atom __false__ = "false";
    }
}

rustler::init!("Elixir.Excoding", [encode, decode]);

#[rustler::nif]
fn decode<'a>(env: Env<'a>, in_binary: Binary, enc: String) -> NifResult<Term<'a>> {
    match encoding_from_whatwg_label(&enc) {
        Some(encoding) => {
            let in_str = in_binary
                .to_owned()
                .ok_or(Error::Term(Box::new("failed to own binary")))?;
            let res = encoding
                .decode(in_str.as_slice(), DecoderTrap::Replace)
                .map_err(|e| Error::Term(Box::new(e.to_string())))?;
            Ok(res.encode(env))
        }
        None => Err(Error::BadArg),
    }
}

#[rustler::nif]
fn encode<'a>(env: Env<'a>, in_str: &str, enc: String) -> NifResult<Term<'a>> {
    match encoding_from_whatwg_label(&enc) {
        Some(encoding) => {
            let enc_bin = encoding
                .encode(in_str, EncoderTrap::Replace)
                .map_err(|e| Error::Term(Box::new(e.to_string())))?;
            let mut bin = OwnedBinary::new(enc_bin.len())
                .ok_or(Error::Term(Box::new("failed to create owned binary")))?;
            bin.as_mut_slice()
                .write_all(&enc_bin)
                .map_err(|e| Error::Term(Box::new(e.to_string())))?;
            Ok(bin.release(env).encode(env))
        }
        None => Err(Error::BadArg),
    }
}
