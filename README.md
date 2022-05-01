# SalesforceAssignment

Opportunity Mirroring Between two SF orgs.
For this assignment two different salesforce org is required. Using Rest API call, Opportunity records can be mirrored in these two orgs. For ease of understanding we can refer these two orgs as ‘Org A’ and ‘Org B’

The following steps can be used to achieve this:
In Org A, create a new record type for Opportunity as External.
In Org A, create new field 'ExternalID' in Opportunity.
In Org A, whenever an Opportunity of record type 'External' is created, the same is cloned in Org B and the new Opportunity ID created in Org B is returned and stored in 'ExternalID' field.
In Org A, whenever an Opportunity of record type 'External' is updated, the same is updated in Org B (Based on 'ExternalID' field).
