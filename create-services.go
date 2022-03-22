package main

import (
	"fmt"
	"os"

	"github.com/hashicorp/hcl/v2/hclsyntax"
	"github.com/hashicorp/hcl/v2/hclwrite"
	"github.com/zclconf/go-cty/cty"
)

func main() {
	// TODO: set account owner email to be used retrieve user for defining pagerduty_schedule
	ACCOUNT_OWNER_EMAIL := ""

	// create new empty hcl file object
	f := hclwrite.NewEmptyFile()

	// create new file on system
	tfFile, err := os.Create("servicelist.tf")
	if err != nil {
		fmt.Println(err)
		return
	}
	// initialize the body of the new file object
	rootBody := f.Body()

	// initialize terraform object and set provider version
	tfBlock := rootBody.AppendNewBlock("terraform", nil)
	tfBlockBody := tfBlock.Body()
	reqProvsBlock := tfBlockBody.AppendNewBlock("required_providers",
		nil)
	reqProvsBlockBody := reqProvsBlock.Body()

	reqProvsBlockBody.SetAttributeValue("pagerduty", cty.ObjectVal(map[string]cty.Value{
		"source":  cty.StringVal("PagerDuty/pagerduty"),
		"version": cty.StringVal("2.3.0"),
	}))
	rootBody.AppendNewline()

	// create escalation policy
	ep := rootBody.AppendNewBlock("resource",
		[]string{"pagerduty_escalation_policy", "ep"})
	epBody := ep.Body()
	epBody.SetAttributeValue("name", cty.StringVal("Me EP"))
	epBody.SetAttributeValue("num_loops", cty.NumberIntVal(3))
	epBody.AppendNewline()
	// rule block
	epRule := epBody.AppendNewBlock("rule", nil)
	epRuleBody := epRule.Body()
	epRuleBody.SetAttributeValue("escalation_delay_in_minutes", cty.NumberIntVal(30))
	epRuleBody.AppendNewline()
	// target block
	epRuleTarget := epRuleBody.AppendNewBlock("target", nil)
	epRuleTargetBody := epRuleTarget.Body()
	epRuleTargetBody.SetAttributeValue("type", cty.StringVal("schedule_reference"))
	// pagerduty_schedule resource reference using SetAttributeRaw
	schedTokens := hclwrite.Tokens{
		{Type: hclsyntax.TokenIdent, Bytes: []byte(`pagerduty_schedule.foo.id`)},
	}
	epRuleTargetBody.SetAttributeRaw("id", schedTokens)
	// pagerduty_schedule resource reference using SetAttribute (here for reference)
	// epRuleTargetBody.SetAttributeTraversal("id", hcl.Traversal{
	// 	hcl.TraverseRoot{
	// 		Name: "pagerduty_schedule",
	// 	},
	// 	hcl.TraverseAttr{
	// 		Name: "foo",
	// 	},
	// 	hcl.TraverseAttr{
	// 		Name: "id",
	// 	},
	// })
	rootBody.AppendNewline()

	// create schedule
	sched := rootBody.AppendNewBlock("resource",
		[]string{"pagerduty_schedule", "foo"})
	schedBody := sched.Body()
	schedBody.SetAttributeValue("name", cty.StringVal("Me Schedule"))
	schedBody.SetAttributeValue("time_zone", cty.StringVal("America/Los_Angeles"))
	schedBody.AppendNewline()
	// layer block
	schedLayer := schedBody.AppendNewBlock("layer", nil)
	schedLayerBody := schedLayer.Body()
	schedLayerBody.SetAttributeValue("name", cty.StringVal("This Shift"))
	schedLayerBody.SetAttributeValue("start", cty.StringVal("2022-03-15T20:00:00-08:00"))
	schedLayerBody.SetAttributeValue("rotation_virtual_start", cty.StringVal("2022-03-15T20:00:00-08:00"))
	schedLayerBody.SetAttributeValue("rotation_turn_length_seconds", cty.NumberIntVal(86400))
	// users attribute with hclwrite.Tokens and SetAttributeRaw
	userTokens := hclwrite.Tokens{
		{
			Type:  hclsyntax.TokenOBrack,
			Bytes: []byte(`[`),
		},
		{
			Type:  hclsyntax.TokenIdent,
			Bytes: []byte(`data.pagerduty_user.me.id`),
		},
		{
			Type:  hclsyntax.TokenCBrack,
			Bytes: []byte(`]`),
		},
	}
	schedLayerBody.SetAttributeRaw("users", userTokens)

	// add restriction to schedule layer
	schedLayerBody.AppendNewline()
	restriction := schedLayerBody.AppendNewBlock("restriction", nil)
	restBody := restriction.Body()
	restBody.SetAttributeValue("type", cty.StringVal("daily_restriction"))
	restBody.SetAttributeValue("start_time_of_day", cty.StringVal("17:00:00"))
	restBody.SetAttributeValue("duration_seconds", cty.NumberIntVal(54000))
	rootBody.AppendNewline()

	// get user
	me := rootBody.AppendNewBlock("data",
		[]string{"pagerduty_user", "me"})
	meBody := me.Body()
	meBody.SetAttributeValue("email", cty.StringVal(ACCOUNT_OWNER_EMAIL))
	rootBody.AppendNewline()

	// create a lot of services
	for i := 1; i <= 50; i++ {
		service := rootBody.AppendNewBlock("resource",
			[]string{"pagerduty_service",
				fmt.Sprintf("me%v", i)})
		serviceBody := service.Body()
		serviceBody.SetAttributeValue("name",
			cty.StringVal(fmt.Sprintf("Me Service %v", i)))

		// defining tokens for pagerduty_escalation_policy resource reference
		tokens := hclwrite.Tokens{
			{Type: hclsyntax.TokenIdent, Bytes: []byte(`pagerduty_escalation_policy.ep.id`)},
		}
		serviceBody.SetAttributeRaw("escalation_policy", tokens)
		rootBody.AppendNewline()
	}

	fmt.Printf("%s", f.Bytes())
	tfFile.Write(f.Bytes())
}
