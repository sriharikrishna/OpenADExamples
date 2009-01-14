clean: 
	cd OneMinute && $(MAKE) $@
	cd OneMinuteReverse && $(MAKE) $@
	cd ShallowWater && $(MAKE) $@

.PHONY: clean
