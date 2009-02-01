clean: 
	cd OneMinute && $(MAKE) $@
	cd OneMinuteReverse && $(MAKE) $@
	cd ShallowWater && $(MAKE) $@
	cd Lion && $(MAKE) $@

.PHONY: clean
