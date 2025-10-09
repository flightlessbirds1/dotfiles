#import "template.typ": *

#show: project.with(author: (firstName: "First", lastName: "Last"), title: "Title")

Test

#quote(
  attribution: <citizen>,
)[ Fact is, you can't satisfy both calibration and error rate balance if the base
  rates differ... ]

#bibliography("refs.yml", style: "ieee")
