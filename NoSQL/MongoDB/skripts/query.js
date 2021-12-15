db.members.find({"member.memberships": {$elemMatch:{"membership.represents":{$elemMatch:{"represent.representCode":"Louth"}}}}}).pretty()



db.debats.find({"debateRecord.debateSections.debateSection.counts.speechCount":{$lt: NumberDecimal("4")}, "debateRecord.debateSections.debateSection.debateType":"questions" }).explain("executionStats")

db.debats.createIndex({"debateRecord.debateSections.debateSection.counts.speechCount": 1, "debateRecord.debateSectrions.debateSection.debateType":1 })

// MongoDB server version: 5.0.4