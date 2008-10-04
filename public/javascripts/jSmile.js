(function(list){
// JSmile for jQuery - Andrea Giammarchi [webreflection.blogspot.com] - V0.4
jQuery.fn.extend({
	smile: (function(){
		function smile(show){
			show = !arguments.length || !!show;
			this.each(function(i, firstChild){
				jQuery.each(firstChild.childNodes, function(i, firstChild){
					switch(firstChild.nodeType){
						case	1:
							show ? jQuery(firstChild).smile(show) : smile.remove(firstChild);
							break;
						case	3:
							if(show && !smile.nodeName[firstChild.parentNode.nodeName.toLowerCase()])
								smile.add(firstChild);
							break;
					}
				});
			});
			return	this;
		};
		smile.add	= function(firstChild){
			var	parentNode	= firstChild.parentNode,
				nodeValue	= firstChild.nodeValue,
				i           = 0,
				length		= 0,
				img;
			nodeValue.replace(
				smile.RegExp,
				function(createTextNode, pos){
					if(++length < smile.max && list[createTextNode]){
                        if(smile.list[createTextNode])
                            img = smile.list[createTextNode].cloneNode(true);
                        else {
    						img             = new Image();
    						img.className   = smile.className;
    						img.src         = "data:image/gif;base64," + list[createTextNode];
                            img.alt         = img.title = createTextNode;
                            smile.list[createTextNode]  = img;
                        };
						jQuery(firstChild).before(document.createTextNode(nodeValue.substring(i, pos))).before(img);
						i   = pos + createTextNode.length;
					}
				}
			);
			if(i)
				jQuery(firstChild).before(document.createTextNode(nodeValue.substring(i))).remove();
		};
		smile.remove	= function(firstChild){
			jQuery(firstChild).find("img." + smile.className).each(function(i, firstChild){
				jQuery(firstChild).replaceWith(document.createTextNode(firstChild.alt || firstChild.title));
			});
		};
        smile.max       = 20;
        smile.list      = {};
        smile.className = "jsmile";
        smile.nodeName  = {"code":1,"noscript":1,"pre":1,"script":1,"style":1};
        smile.RegExp    = /:arrow:|:cry:|:evil:|:geek:|:idea:|:lol:|:mrgreen:|:oops:|:roll:|:shock:|:twisted:|:ugeek:|8-\)|:o|:x|:\||:!:|:\(|:\)|:\?:|:\?|:D|:P|;\)/g;
        return  smile;
    })()
});
})({"8-)":"R0lGODlhDwAPALMNAP\/qAEVFRQAAAP\/OAP\/JAP6dAP+0AP\/+k\/\/9E\/\/\/x\/\/\/\/\/\/lAP\/\/6wAAAAAAAAAAACH5BAEAAA0ALAAAAAAPAA8AAARZsEkZap24VZbOGRcWcAgCnEMRTEFnnnC6ascLx2sr7DvA76rAgacQ+HZFQ+VwNJ54BGXAdoNFK4PqbUFQabJOmIAAogwGi99YxjoT3m+2KGCoG4IZlmU2iQAAOw==",":evil:":"R0lGODlhDwAPAMQQAEVFRf\/qAAAAAP\/OAP\/JAP6dAP\/9E\/+0AP8AAP\/+k\/\/\/x\/4qAP5tA5aWlv\/lAP\/\/6wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAABAALAAAAAAPAA8AAAVpIABApGiSkLmYj5IkgyoyhaEYRqAPQ8GINUBORwT0AA1AwiAg6pqx5C0gaD6bhIJoKUBUqV0B4bClIhDEs5gsvBK\/Y9HASXdkR8ZrFRsr8aw6DgJHKEYDBIiIhCgpAAePB1ojjIUmkyghADs=",":geek:":"R0lGODlhEQARANU\/ALvqHf6rDf\/yHGRXNv6lDP6zDrvjHJpyHNeMEbvtV1xNNLvxWP7aFf67D2upLf7MEZDQX2ZaPvb29pGLeEU6J3VoRbq4sv\/oGf\/lGP7VFLvyIP\/tG\/nvI7vrV3xyXpuYjerp6O7u7dXU0dbGMO6ZDnluWbbnV+3VHX9UBuy+FPDw75iDQ9zb2H5eJ35zYLvvH8J\/Ev7gF7SeLm5hRubUOe6qEHNkPcCBErLeHdmYEoFcJfvtH\/7DDzMzMwAAAPr6+iH5BAEAAD8ALAAAAAARABEAAAa3wJ\/wJ5lUIrbIbCIZOkUVGkewuZxkA5Hz91lNBVRMjJEafIYqxQ4MvmAYmUeKEhJORht2dfzg8Q4TQj6DhD4YhYQ\/Pg4vGo6OPguSCZQQg4wvLz4vAJELPpQJlosApT4ABpEJoB0dow44BrKyoAmtHSaWiog+Bbw+QiIDDcQFxgEBBMoKLEMeBw3HyCjKBx5OIRQ1xj3dyiR0WyAUOcjKBAgUIFtCIBEtNwgwOgrr7EMWHjMlFuxBADs=",":idea:":"R0lGODlhDwAPALMNAEVFRf\/qAAAAAP\/\/\/\/\/OAP\/JAP+0AP\/9E\/6dAP\/+k\/\/\/x\/\/lAP\/\/6wAAAAAAAAAAACH5BAEAAA0ALAAAAAAPAA8AAARdsEkJap24VaZSIhcGcMcRnAQCTEBnCjCqUsk73AK6tvaNBwUVoBYQ4H4FQyVxMg6cuWTF1Hw+T1IA4dSMBRbB3babA4IoBMKiCAOnVmhCoSCYvzMVg94gzLAscBMRADs=",":lol:":"R0lGODlhDwAPALMNAEVFRf\/qAAAAAP\/\/\/\/\/OAP\/JAP+0AP6dAP\/9E\/\/+k\/\/\/x\/\/\/6\/\/lAAAAAAAAAAAAACH\/C05FVFNDQVBFMi4wAwEAAAAh+QQFFAANACwAAAAADwAPAAAEWrBJCWqduNWlUiIXBiyCgARBeQAToJhonK5UcgoxHoCacuspXGEFsMmOBUMlATymlABEaUotQQmpgXY7EAxZAKyA2y3wNAQCo2qmUdKFeJzgbgEMeAMxY7dkIgAh+QQFFAANACwCAAIACwAHAAAEE7BJJFuoOOvNq+if8GGiNAzZ2UQAIfkEBQoADQAsBQAHAAUAAgAABAVQSDlqjQAh+QQFCgANACwFAAcABQACAAAEBTBIKWqNACH5BAUKAA0ALAUABwAFAAIAAAQFUEg5ao0AIfkEBRQADQAsBQAHAAUAAgAABAUwSClqjQA7",":mrgreen:":"R0lGODlhDwAPANUAAAAAAP\/\/\/wDywwDuvwDsvgDqvADktwDitgDgtADcsQDarwDYrgDWrADSqQDOpgDKogDIoQDGnwDEngC+mQC8lwC4lAC0kQCyjwCujACqiQCohwCmhQCggQCcfQCafACWeQCOcgCKbwCGbACCaQB+ZQB8ZAB4YP\/\/\/wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAACcALAAAAAAPAA8AAAZ6wJNQCCgWh8hTcQJpKAxHJEBzoTQVh4IAMAR0NkWJY1EcbIkeAKYCeAASBwCBCwB9OBkLJeJgJBAGUAAhRoWFCUUiAAEBi4yOAA1FI5CMjY8QRSWVj48TdCSLjpcAF1xKJqGjRRsap6iqRh4dr0QAJSMiISBRSUqFSUEAOw==",":o":"R0lGODlhDwATANU\/AP6zDv7OEpKLeem3FOvr6uKfEP\/yHFRFK3FmSrl7FGJXOJmViv7CD\/6pDfG4Ef6mDUE4JvrvIOTj4VtNL15SNv7HEP7UFNGLEf6tDd3c2v7ZFf\/pGf6+D\/7dFv\/tG\/65DmpSLP\/lGHNkNv3hGG1hPvPy8v\/++tPSzuugD52HQvOfDezUHWVbQYd+bPXIE+XXOLKaLs3Lx01EL1FFMcTCvZV0H9fKMNakFHluWX10X8CaF\/\/\/+ks+Kf\/\/\/wAAAPr6+iH5BAEAAD8ALAAAAAAPABMAAAbIwJ+wJECQRAqEQMj8nUiviMGzWcFYGeYiJTVMQyPNgLL4EShd7ybUsQQcEKLNw6tTR3UeoyZQ4HeAPCE8gDs8AzJ+hD6GeCaMPB8HIh2LhhqWPAAHFBqYnm4VDB+aADwyLgGqAaKjAAAYKDM5OhW2DAm5sA0NCS00IgzCHD3FGLwPIDE\/LDccHB8+0g0PDxcIQhkTDh8A0j7UKjwSWiCv39UgZU0Q59LWFE1CFAUYx9UJOPI\/EgcXvCoS8CCwjx8CCAd45CDIJAgAOw==",":oops:":"R0lGODlhDwAPAMQfAPqzAP3KAOBsAPeOW\/\/3zftoaP62dfecAP\/Sh\/ykaf+3t\/6YmOdzSkVFRf\/k5P\/69f\/MzP\/qAPiAgP\/86frXAP7jAPmmpv\/8E\/7Lg\/\/+k+NfX9lINgAAAP\/lmfrBewAAACH\/C05FVFNDQVBFMi4wAwEAAAAh+QQFFAAfACwAAAAADwAPAAAFZuAnik1ZjuhXTkSWBSfasNcV3cHRjE3L3UBObqfK\/IBBmIpgixydOF0jY+M8rZEAoJSpUCrIiFdbugAAFGTlfC6dDwHwjQI42HcNQCBt5XjhRA0BcWqDOjyDiYmHMnlsUik8JkQjIQAh+QQFCgAfACwBAAEADQANAAAFUeAnfs9EEMY4ll2HvMYwmt9rf7FI1PadTi4ETwgbEFyiW82QIHgMmB7imUggBgyrzYMdVBmbQc8AZsgGA49QhEl4RQZoDxOXweP4ukpUrdpFIQAh+QQFMgAfACwBAAEADQANAAAFSOAnik65jKgDQUq7FGP5tfT3kjNdn2qbK7lXT1SbLSQOi0XXUh4VEs1CZ4lKrpqPhJotwK7LkeIlES2mzDPMfG6rUaLrdS0KAQAh+QQFCgAfACwBAAEADQANAAAFUOAnihNBGGM6dR3iGsNYfm79wSJB1za6ujvEDkZoiWw0Q4LgMWB4iGYigRgwqDWPdTBlfAY8g5cRGww8QhEmwRUZnDzMO+Z+2+cp0XRKF4UAACH5BAUKAB8ALAEAAQANAA0AAAVR4Cd+E5FlwTiW1xW9wTGa32t\/sZjV9p0SrghPCDtkXKJbLQDIUAKVXuTJjBwEgB7legAABIJDLwA+yAAHilBUQQNEAWivEpfB4\/i6SuT12kUhADs=",":roll:":"R0lGODlhDwAPALMNAEVFRf\/qAAAAAP\/OAP\/JAP\/\/\/\/6dAP+0AP\/+k\/\/\/x\/\/9E\/\/lAP\/\/6wAAAAAAAAAAACH\/C05FVFNDQVBFMi4wAwEAAAAh+QQFCgANACwAAAAADwAPAAAEXrBJCWqduFWWEBoXBnCKEpyDAUxAJwhn8KarhghFAeM6qCW8XFCnAtx0uGTyUEHIXjsogQkwPWOvwLQyiHlPC4JK0\/2eCD7yYAGAAtBjymBAqNdpmcphfyhmWBY1ExEAIfkEBQoADQAsBAAFAAgAAwAABAqwiFnkvFbYoGcEACH5BAUKAA0ALAQABAAHAAQAAAQLsIlG5ayz1Kb5LhEAIfkEBTIADQAsBAAEAAgAAwAABApQtNkkLbThgiePACH5BAUUAA0ALAkACgACAAIAAAQEsAnRIgAh+QQFCgANACwEAAQABwAEAAAEDbCURmUBtIErMOhahkUAIfkEBQAADQAsAgACAAsABwAABB2wSSEbrTJUXVX4zQcqQikEpkBMTdFaWFnJGxdyEQAh+QQFAAANACwCAAIACwAGAAAEFrBJJVuoOFehG7dBCIrKJwQmMV6hGAEAIfkEBQAADQAsAgACAAsABgAABBawSSEbrThLpVuYQmiFlFBIhYmW5ChGADs=",":shock:":"R0lGODlhDwAPALMNAP\/\/\/wAAAP\/qAEVFRf\/OAP\/JAP+0AP6dAP\/lAP\/9E\/\/+k\/\/\/6\/\/\/xwAAAAAAAAAAACH5BAEAAA0ALAAAAAAPAA8AAARXsEk5ap241cWUIhcWjEkinGMwBUAbnALrNnILvLUr77Gr264eMDCovVA24iCRgqFGhgrBSUUUDgPN9HksgCgEAsJpJWAng3BhvTZnMRWD3IB9ZzQWuyQCADs=",":twisted:":"R0lGODlhDwAPAMQRAEVFRf\/qAAAAAP\/OAP6dAP\/9E\/+0AP8AAP\/\/\/\/\/+k\/\/JAP\/\/x\/4qAJaWljMzM\/5tA\/\/\/6wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAABEALAAAAAAPAA8AAAVrIABEpGiSkcmY0JIkgyo+RLEURaAPA\/GINUBORwT0AA1AoiAg6pqx5C0gaD6bCoJoKThUqV2BwrClHg7Es5gsvBK\/Y9Eg4HASHdmRscrvx0o8AgiDgwJHKEYxfEZaKCUABpEGWiOOiCaVKCEAOw==",":ugeek:":"R0lGODlhEwASANU\/AP67D4\/KgbWWI\/7YFP6qDY\/SgmZZNv6zDv6kDOHz3f\/yHHt1bZptGkU6J9uUEUSdllNIMlZGLfb29o\/dhP7JEY\/hhjmRkXVoRbq4sv\/oGf\/lGPnuIv\/tG\/7BD4\/Yg4iAbj4+O5uYjUtALuH43+rp6O7u7dXU0W9jQ+3VHe6ZDtzb2GJXPu6qEJiDQ+i\/Fn1zX\/7gF\/Dw78vk40lFO+bUOVxQOenp55WQfJKNe3NkPX5eJ4FcJd7w3vC8EgAAAPr6+iH5BAEAAD8ALAAAAAATABIAAAbDwJ9QKLldDDnDCScZOoWmC22j4GRQgpXpKQy1qIpqBjZwGUJD3y9WA4czGjKl1yj91L683meF7fVCPjIjhIQ+Gj4Jigk8Fmp3DxMVk5M+HgUFAZqOgZETeROfmHmbjzaWHqkePhQ+mq8+MUMQfx0AAH8QTh8CHb63BwcEwwgMH04mBrcAwcLECBEqTy8MzAd6CNkML1wlDSzBzwgpdVw\/Ng0OBBHsCA4NJOZCNis6Ivc7NfHyQxggMyAw8OOyAMQCeUEAADs=",":x":"R0lGODlhDwAPALMNAP\/qAEVFRQAAAP\/OAP\/JAP+0AP6dAP\/+k\/\/9E\/\/\/\/\/\/\/x\/\/\/6\/\/lAAAAAAAAAAAAACH5BAEAAA0ALAAAAAAPAA8AAARbsEkZap241aXOGRcWcAgCnIMRTEEnnLCQrtphvicOaooJ\/wCCKmADCHDGF6FQOcSeQWbAB4QtK4PY8QhgCFeBrCBBJgsIO81gsG3PWGuCXP4WBQr4wjDDstAmEQA7",":|":"R0lGODlhDwAPALMMAP\/qAEVFRQAAAP\/OAP\/JAP6dAP+0AP\/+k\/\/9E\/\/\/x\/\/lAP\/\/6wAAAAAAAAAAAAAAACH5BAEAAAwALAAAAAAPAA8AAARYkEkZap2Y1ZXOGRcWcAgCnEMRTEEnnKcgpKt2vHAOaokJ4L8TQRU4+IA4gqFyyDkByorvKVwGBtSTYri6\/mRgAWGnGQwUuS2NZSa43WtRwEA3EDMsS20SAQA7",":!:":"R0lGODlhDwAPAMQdAP\/qAEVFRf\/OAP\/JAP\/9E\/+0AP6dAP\/+k\/\/\/x391AP\/lAAAAAL+vAP\/\/68W1Bi8vL9LBBfPfBHFvV3JwWL+wAEpHKbGiAgMDA21rUxQUFOnXBvvnAFNPJgAAAAAAAAAAACH5BAEAAB0ALAAAAAAPAA8AAAVpYCeKQVmOaFc2yHEIJxqwBAHcghGMQWsnCwZORzrYAEAhbtc7Ii+UG2CgCxillox0Wigdto7KdtANOAEOzrgs2G4gUgWV2b5JHpPbAEYSCBQAGhgRcjk7fQIDioqGKSUFkAVVKTwmhyMhADs=",":(":"R0lGODlhDwARANU\/AGNWM\/\/yHNeMEf7UE\/6tDf6mDVZMM\/6oDWNXQP7HEOi\/Fv\/pGVJFL+ubD0U6J\/7cFvb29v6xDv6+D5KMeHFjOnVoRbq4sv\/lGP\/tG\/61DvnuIv7DD19UOptpGP65DoiAbnxyXpp3HZuYjerp6O\/v7v6jDPr6+gAAAPzhGZiDQ25hRrSeLu6tEX5eJ9mYEn5zYN7NNdzb2MGAEu+9Eu3VHYqEc5WQfLWOGHluWYFcJf\/\/+l1IKmhbOdXU0Us+Kfr6+iH5BAEAAD8ALAAAAAAPABEAAAbBwJ8QYqvwKDzVBCJs9iowTQCzoK04vaYopeHxAouFVwEQ\/UiGbmC9uDwGvJmDVINh1tMFavBIbEI1HCgLPoVtD4U+EiwMACg+PZE+iJE9PhkMFIg6PiY+A50+nBE7BqA6J5wJoqk+EQ4MMwmzGxsSHhkRBAQNDB83tRK3uQQHxh0fPQDCHjvOzgXROzE\/ICHNusUFOyUdL0IkDiwRugcFJSUNc00jDi7a6AIOI01CIwgtMgIyORz09U0sgFCBwwLAIAA7",":)":"R0lGODlhDwARANU\/AJpwG\/7SE\/7KEP6kDP\/yHHJuZdeMEf\/kGFVLM\/\/pGWNXQP6xDui\/FltILOubD0Y6J\/6sDfb29v7cFv65Dv7ZFf7CD5KMeP61DnFjOv\/tG3VoRbq4sv7FEP6oDf69D\/nuImNWM19UOmlcO4iAbn1yXpuYjerp6O\/v7tfW0\/zhGJiDQ+2wEe+9EnluWcJ\/EtbGMG5hRu6qEO3VHYqEc7WWI5WQfMCBEtmYEoBdJlFELubUOVxXSAAAAP\/\/\/zMzM\/r6+iH5BAEAAD8ALAAAAAAPABEAAAa9wJ8wUtOIMCKYJSJsojC6DyGTkNEUqGZJJSUQEokUhQEq\/U4I6W73PawFrMfJ8sqwp2GKYMcBzEIpYBlUBxIBHBUeKzkgKQcHPDyFAZEeExM5GBQSEmsUAXs7ExcLDQgBqKgCiB6kCwsPCCwCBRysowsFEA4IIzQcPsHCwgMAIyggEx4+Pc3NPh0DDVkkAKPDPgPFJEInDzGkEB3RAw5yTSYPN+LkBg8mTUImCjg2Bi44IfDxTRskMC028AsCADs=",":?":"R0lGODlhDwARANU\/AJpwG\/6kDP7bFf\/yHNeMEf7KEP6xDo2HdlVLM\/6tDWNXQP6oDey9E1tILOubD0U6J\/b29v62Dv7CD5KMeHFjOv69D3VoRbq4sv65Dv\/oGf\/lGP7FEP7SE\/\/tG\/nvI2NWM19UOmlcO4iAbnxyXpuYjerp6O7u7dXU0fzhGO6tEZiDQ9zb2H5zYO3VHebUOZWQfG5hRnluWbuIFdmYEsJ\/EoFcJX5eJ1FELvDw77SeLvvtH9bGMP\/\/+ks+KQAAAPr6+iH5BAEAAD8ALAAAAAAPABEAAAa3wJ8Q8rKEKCHYBCJsniwuz6CTaeVApyZJJR1MMwIB40P64RA6rzejEXAKjIdpsuv07lTUvbcBHEB6PII9Gj2CPD0pNx+BPD49AoaOPRg3FAIHgj4HHJKbBg0IHBycbxsSFREHBgk9CAwFG7KoGBGsCQ43IjKnFRW1twsBACInH7S2rAvLAQ0rPywAwD4+zMMsQiYPKQbKwgEOck0lDzMJ1gQPJU1CJQo2NAQ0NSDr7E0XIzAxF\/dBADs=",":?:":"R0lGODlhDwAPAMQaAEVFRf\/qAP\/OAP\/JAP6dAP+0AP\/9E\/\/+k+\/bAH91AAAAAN\/NAP\/\/x8++AA8OAL+vAP\/lAC8rAJ+SAP\/\/6x8cAF9XAN+wAO+8AL+XAG9mAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAABoALAAAAAAPAA8AAAV1oCaKQFmOqFZOzHEIJwqwhhHcAgGMQGsskooEEcjtVAcDwkFJUBSL4q5nS0ADy0xgoAMksY1bQ5HYFkqHm7rhiBAHZ4BNHWgTzSUB\/aF43CBcU3piCVFbMCQCAhABVg+ARjyKAxYYFwORMgAFnAVdKTwmRyMhADs=",":D":"R0lGODlhDwARANU\/AP67D\/\/yHP\/kGFRCKXJuZUQ5JteQEf6rDf7IEFZMM\/6kDGNXQP7cFui\/Fv61DuubD\/7SE\/b29v\/oGf7ZFZKMeHFjOv\/tG3VoRbq4svnvI\/7CD2NWM5qXjV9UOptpGGlcO4iAbn1yXpp3Herp6O7u7dXU0eXk4v7gF4FcJX5eJ+2wEZiDQ+6qEJWQfN7NNVJGMe3VHW5hRnluWYqEc7WOGMGAEu+9ErSeLvfhHPvtH\/Dw79zb2F1IKgAAAP\/\/\/\/r6+iH5BAEAAD8ALAAAAAAPABEAAAa6wJ8w0rp8Kp8YJSJsli6uTMAigd06pSZnJQ1MJadJY8P56RI5r1ciYEAQtgJp5rIEej3qCY\/QiGYdOBJ5FgQCBG89ACovGycCAhJsbn0AAA4DFRMMnAwTbxqXDg48CRAFeKmqBQ4FLzYDPrKzswMPLyA0Ghy0sxwHHiAlGwADJr0mAwo8Oz8hIgA8vTwKHiFCJAUspDwoPNQPck0jBQYHBwrpBgUjTUIjCyk1BjUoHe3uTRgyMTIY+UEAADs=",":P":"R0lGODlhDwAPALMOAP\/qAEVFRQAAAP\/OAP8AAP\/JAP+0AP6dAP\/9E\/\/+k\/\/\/x\/\/\/6zMzM\/\/lAAAAAAAAACH5BAEAAA4ALAAAAAAPAA8AAARd0EkZap3Y1aVSGhcWcAgCnMMRTEEnCCfwpquWmHEOagoOn7+CKnADxoKGSiLHBBSSAROjCWA8KwPZa7sVrgJZAWE8FhR2msGgESAHziqWutB+0zIVg94wzLAsNRMRADs=",":arrow:":"R0lGODlhDwAPALMMAP\/qAEVFRQAAAP\/OAP\/JAP\/9E\/6dAP+0AP\/+k\/\/\/x\/\/lAP\/\/6wAAAAAAAAAAAAAAACH5BAEAAAwALAAAAAAPAA8AAARXkEkZap2Y1ZUQGhcWcEUBnIMRTEFnnnC6asgLCEK8tvaJnwRVoHbDGXOEQwXhOxqTlZfzBw0MYLCfIri7ZnMAAogyGCiwWxmrTGi31aLAYX4QZliW2SQCADs=",":cry:":"R0lGODlhDwAPAMQQAP\/qAEVFRQAAAP\/OAP\/JAP6dAP+0AP\/+k\/\/9E\/\/\/\/\/\/\/x\/\/\/6\/\/lAACM2IG71l5eXgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH\/C05FVFNDQVBFMi4wAwEAAAAh+QQFHgAQACwAAAAADwAPAAAFXCAkikFZjihULspxDCcasAgC3EMRjEEr3EBBbqc6\/IBBmEphQyIJusDBJjgCqgCCoXRwOrWlpvcGDgzGNwZ0Z75V31mlajB4IBmPIY9O6Pf1MgEGgwZRKTwmRCMhACH5BAUUABAALAQABQAHAAcAAAURICRA5EieZNKcTYK+MGyeQggAIfkEBQoAEAAsBAAIAAcAAQAABQZg4kCkk4QAIfkEBQoAEAAsBAAHAAcAAwAABQogII5AkoymiSYhACH5BAUKABAALAQACAAHAAMAAAULIABApEieZIJCSQgAIfkEBQoAEAAsBAAHAAcABAAABQ1g0gBkk5BoqgJC2wIhACH5BAUKABAALAQACAAHAAEAAAUGYOJApJOEACH5BAUKABAALAQABwAHAAMAAAUKICCOQJKMpokmIQAh+QQFCgAQACwEAAUABwAGAAAFDyAEQORInmgKmCKLJmkSAgA7",";)":"R0lGODlhDwARANU\/ALWWI+i\/FmVYNJpwG\/7SE\/6kDP7KEP\/yHNeMEf\/kGP6xDlVLM\/6tDf\/pGf69D2ZaPv65Dv7cFv7CD\/61DlZGLf7GEOubD0Y6J\/b29v7ZFZKMeHFjOv\/tG3VoRbq4sv6oDfnuIl9UOoiAbn1yXpuYjVxXSOrp6NXU0e7u7YZ+bP7gFwAAANmYEpWQfMJ\/EvfhHObUOZiDQ9zb2PDw79bGMO+9En5eJ25hRu6tEXluWYqEc8CBEoFcJe3VHTMzM\/r6+iH5BAEAAD8ALAAAAAAPABEAAAa6wJ8Q0+o8No+bBiNsnjow0IHT6AEepyYpJj0cGg1VJiAg\/WYLaan0TUQIhtoFpaFx2NNwxlCpDHQhL2AcVG4EFRIOOAsCKgkJKyuGPj4OEBAUGxkREWsZcIkQEwoUCwSnp3yJowoKFws1fH2hEykMDBYUKQASiZajDD4fBQMiJwIOv63BH8MUMj8jA6IplMIFxCNCKBc4y83YFnNNJhcsDOAFCBcmTUImDzY7CC48Ie3uTR4jNzke+UEAADs="});