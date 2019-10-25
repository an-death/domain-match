#![feature(test)]

extern crate test;
use test::Bencher;

extern crate serde;
extern crate serde_json;
#[macro_use]
extern crate serde_derive;
extern crate glob;
use glob::Pattern;
use std::assert_eq;
use std::env::args;
use std::fs::File;
use std::io::Read;
use std::string::String;

const TEMPLATES_FILE: &str = "templates.json";

#[derive(Serialize, Deserialize, Debug)]
pub struct Template {
    template: String,
}

pub fn read_json_data() -> Vec<Template> {
    let mut file = File::open(TEMPLATES_FILE).expect("templates.json");
    let mut data = String::new();
    file.read_to_string(&mut data).unwrap();

    let templates: Vec<Template> =
        serde_json::from_str(&data).expect("JSON was not well-formatted");
    templates
}

pub fn parse_patterns(raw_patterns: &Vec<Template>) -> Vec<Pattern> {
    let patterns: Vec<Pattern> = raw_patterns
        .iter()
        .map(|p| Pattern::new(&p.template).unwrap())
        .collect();
    patterns
}

fn main() {
    let arg: Vec<String> = args().collect();
    let domain = &arg[1];
    let patterns: Vec<Pattern> = parse_patterns(&read_json_data());

    for pattern in &patterns {
        let matched = pattern.matches(&domain);
        if matched {
            println!("{}:{}", pattern, matched);
        }
    }
}

#[bench]
fn match_glob_com(b: &mut Bencher) {
    let raw_templates = read_json_data();
    let email = String::from("test@subdomain.domain.spottradingllc.com");
    let expected = String::from("*.spottradingllc.com");
    b.iter(|| {
        let patterns: Vec<Pattern> = parse_patterns(&raw_templates);
        for pattern in &patterns {
            if pattern.matches(&email) {
                assert_eq!(expected, pattern.as_str())
            }
        }
    })
}

#[bench]
fn match_glob_org(b: &mut Bencher) {
    let raw_templates = read_json_data();
    let email = String::from("test@domain.nyumc.org");
    let expected = String::from("*.nyumc.org");
    b.iter(|| {
        let patterns: Vec<Pattern> = parse_patterns(&raw_templates);
        for pattern in &patterns {
            if pattern.matches(&email) {
                assert_eq!(expected, pattern.as_str())
            }
        }
    })
}
