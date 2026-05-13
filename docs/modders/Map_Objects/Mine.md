# Mine

Multiple mine object types may produce the same resource.

Beside the common parameters from [Map Object Format](../Map_Object_Format.md) there are some additional parameters:

```json
{
	/// produced resource
	"resource" : "mithril",

	/// amount of resources produced each day
	"defaultQuantity" : 1,

	/// displayed name of mine
	"name" : "name text",

	/// displayed description of mine (for popup)
	"description" : "description text",

	/// Optional guards for non-abandoned mines only.
	/// Uses the same stack format as other configurable guard lists.
	"guards" : [
		{ "type" : "core:marksman", "amount" : 40 }
	],

	/// Optional message shown when hero attempts to visit guarded non-abandoned mine.
	/// Falls back to default mine/abandoned messages when not set.
	"onGuardedMessage" : "Do you wish to fight the guards?",

	/// Image showed on kingdom overview (animation; only frame 0 displayed)
	"kingdomOverviewImage" : "image.def"
}
```

## Notes

- `guards` and `onGuardedMessage` apply only to regular `mine` object types.
- `abandonedMine` keeps original hardcoded guard-generation behavior.
