package main

import (
	"fmt"
	"os"

	"github.com/hashicorp/hcl/hclwrite"
	"github.com/zclconf/go-cty/cty"
)

func main() {
	// create new empty hcl file object
	f := hclwrite.NewEmptyFile()

	// create new file on system
	tfFile, err := os.Create("bservelist.tf")
	if err != nil {
		fmt.Println(err)
		return
	}
	// initialize the body of the new file object
	rootBody := f.Body()

	// initialize terraform object and set provider version
	tfBlock := rootBody.AppendNewBlock("terraform", nil)
	tfBlockBody := tfBlock.Body()
	reqProvsBlock := tfBlockBody.AppendNewBlock("required_providers", nil)
	reqProvsBlockBody := reqProvsBlock.Body()

	reqProvsBlockBody.SetAttributeValue("pagerduty", cty.ObjectVal(map[string]cty.Value{
		"source":  cty.StringVal("PagerDuty/pagerduty"),
		"version": cty.StringVal("1.10.0"),
	}))

	// create 50 business services
	for i := 1; i <= 150; i++ {
		bs := rootBody.AppendNewBlock("resource", []string{"pagerduty_business_service", fmt.Sprintf("bs%v", i)})
		bsBody := bs.Body()
		bsBody.SetAttributeValue("name", cty.StringVal(fmt.Sprintf("Business Service %v", i)))
		rootBody.AppendNewline()
	}

	fmt.Printf("%s", f.Bytes())
	tfFile.Write(f.Bytes())
}
