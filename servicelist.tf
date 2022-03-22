terraform {
  required_providers {
    pagerduty = {
      source  = "PagerDuty/pagerduty"
      version = "2.3.0"
    }
  }
}

resource "pagerduty_escalation_policy" "ep" {
  name      = "Me EP"
  num_loops = 3

  rule {
    escalation_delay_in_minutes = 30

    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.foo.id
    }
  }
}

resource "pagerduty_schedule" "foo" {
  name      = "Me Schedule"
  time_zone = "America/Los_Angeles"

  layer {
    name                         = "This Shift"
    start                        = "2022-03-15T20:00:00-08:00"
    rotation_virtual_start       = "2022-03-15T20:00:00-08:00"
    rotation_turn_length_seconds = 86400
    users                        = [data.pagerduty_user.me.id]

    restriction {
      type              = "daily_restriction"
      start_time_of_day = "17:00:00"
      duration_seconds  = 54000
    }
  }
}

data "pagerduty_user" "me" {
  email = "smcallister@pagerduty.com"
}

resource "pagerduty_service" "me1" {
  name              = "Me Service 1"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me2" {
  name              = "Me Service 2"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me3" {
  name              = "Me Service 3"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me4" {
  name              = "Me Service 4"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me5" {
  name              = "Me Service 5"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me6" {
  name              = "Me Service 6"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me7" {
  name              = "Me Service 7"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me8" {
  name              = "Me Service 8"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me9" {
  name              = "Me Service 9"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me10" {
  name              = "Me Service 10"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me11" {
  name              = "Me Service 11"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me12" {
  name              = "Me Service 12"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me13" {
  name              = "Me Service 13"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me14" {
  name              = "Me Service 14"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me15" {
  name              = "Me Service 15"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me16" {
  name              = "Me Service 16"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me17" {
  name              = "Me Service 17"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me18" {
  name              = "Me Service 18"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me19" {
  name              = "Me Service 19"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me20" {
  name              = "Me Service 20"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me21" {
  name              = "Me Service 21"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me22" {
  name              = "Me Service 22"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me23" {
  name              = "Me Service 23"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me24" {
  name              = "Me Service 24"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me25" {
  name              = "Me Service 25"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me26" {
  name              = "Me Service 26"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me27" {
  name              = "Me Service 27"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me28" {
  name              = "Me Service 28"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me29" {
  name              = "Me Service 29"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me30" {
  name              = "Me Service 30"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me31" {
  name              = "Me Service 31"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me32" {
  name              = "Me Service 32"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me33" {
  name              = "Me Service 33"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me34" {
  name              = "Me Service 34"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me35" {
  name              = "Me Service 35"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me36" {
  name              = "Me Service 36"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me37" {
  name              = "Me Service 37"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me38" {
  name              = "Me Service 38"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me39" {
  name              = "Me Service 39"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me40" {
  name              = "Me Service 40"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me41" {
  name              = "Me Service 41"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me42" {
  name              = "Me Service 42"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me43" {
  name              = "Me Service 43"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me44" {
  name              = "Me Service 44"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me45" {
  name              = "Me Service 45"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me46" {
  name              = "Me Service 46"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me47" {
  name              = "Me Service 47"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me48" {
  name              = "Me Service 48"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me49" {
  name              = "Me Service 49"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

resource "pagerduty_service" "me50" {
  name              = "Me Service 50"
  escalation_policy = pagerduty_escalation_policy.ep.id
}

