/**
 * ProtocolTemplates.h
 * Pre-defined protocol templates for common applications
 * Part of Axionyx Biotech IoT Platform
 */

#ifndef PROTOCOL_TEMPLATES_H
#define PROTOCOL_TEMPLATES_H

#include "ProtocolManager.h"

class ProtocolTemplates {
public:
    /**
     * Get all available protocol templates
     */
    static std::vector<ProtocolManager::Protocol> getAllTemplates() {
        std::vector<ProtocolManager::Protocol> templates;
        templates.push_back(getMammalianCultureProtocol());
        templates.push_back(getBacterialGrowthProtocol());
        templates.push_back(getYeastCultureProtocol());
        templates.push_back(getDecontaminationProtocol());
        templates.push_back(getMultiTempExpressionProtocol());
        return templates;
    }

    /**
     * Template 1: Mammalian Cell Culture
     * Standard protocol for mammalian cells with pre-heating
     * 37°C, 95% RH, 5% CO2
     */
    static ProtocolManager::Protocol getMammalianCultureProtocol() {
        ProtocolManager::Protocol protocol;
        protocol.type = ProtocolManager::MAMMALIAN_CULTURE;
        protocol.name = "Mammalian Cell Culture";
        protocol.description = "Standard mammalian cell culture with 30-minute pre-heat ramp";

        // Stage 1: Pre-heat (30 min ramp to target)
        ProtocolManager::ProtocolStage preheat(
            "Pre-heat",
            37.0,   // Temperature
            95.0,   // Humidity
            5.0,    // CO2
            1800,   // Duration: 30 minutes (for the ramp)
            true,   // Ramp to target
            1800    // Ramp time: 30 minutes
        );
        protocol.stages.push_back(preheat);

        // Stage 2: Culture (indefinite)
        ProtocolManager::ProtocolStage culture(
            "Culture",
            37.0,   // Temperature
            95.0,   // Humidity
            5.0,    // CO2
            0,      // Duration: indefinite
            false,  // No ramping
            0       // No ramp time
        );
        protocol.stages.push_back(culture);

        // Alarm thresholds (tight for mammalian cells)
        protocol.tempAlarmHigh = 38.0;
        protocol.tempAlarmLow = 36.0;
        protocol.humidityAlarmLow = 90.0;
        protocol.co2AlarmHigh = 5.5;
        protocol.co2AlarmLow = 4.5;

        return protocol;
    }

    /**
     * Template 2: Bacterial Growth (E. coli)
     * Standard bacterial culture protocol
     * 37°C, variable humidity, 5% CO2
     */
    static ProtocolManager::Protocol getBacterialGrowthProtocol() {
        ProtocolManager::Protocol protocol;
        protocol.type = ProtocolManager::BACTERIAL_CULTURE;
        protocol.name = "Bacterial Growth (E. coli)";
        protocol.description = "Standard E. coli culture with 15-minute warm-up";

        // Stage 1: Warm-up (15 min ramp)
        ProtocolManager::ProtocolStage warmup(
            "Warm-up",
            37.0,   // Temperature
            60.0,   // Humidity (lower than mammalian)
            5.0,    // CO2
            900,    // Duration: 15 minutes
            true,   // Ramp to target
            900     // Ramp time: 15 minutes
        );
        protocol.stages.push_back(warmup);

        // Stage 2: Growth (indefinite)
        ProtocolManager::ProtocolStage growth(
            "Growth",
            37.0,   // Temperature
            60.0,   // Humidity
            5.0,    // CO2
            0,      // Duration: indefinite
            false,  // No ramping
            0       // No ramp time
        );
        protocol.stages.push_back(growth);

        // Alarm thresholds (more tolerant for bacteria)
        protocol.tempAlarmHigh = 39.0;
        protocol.tempAlarmLow = 35.0;
        protocol.humidityAlarmLow = 50.0;
        protocol.co2AlarmHigh = 6.0;
        protocol.co2AlarmLow = 4.0;

        return protocol;
    }

    /**
     * Template 3: Yeast Culture
     * Standard yeast culture protocol
     * 30°C, variable humidity
     */
    static ProtocolManager::Protocol getYeastCultureProtocol() {
        ProtocolManager::Protocol protocol;
        protocol.type = ProtocolManager::YEAST_CULTURE;
        protocol.name = "Yeast Culture";
        protocol.description = "Standard yeast culture at 30°C with 10-minute pre-heat";

        // Stage 1: Pre-heat (10 min ramp)
        ProtocolManager::ProtocolStage preheat(
            "Pre-heat",
            30.0,   // Temperature (lower for yeast)
            70.0,   // Humidity
            0.04,   // CO2 (ambient - not critical for yeast)
            600,    // Duration: 10 minutes
            true,   // Ramp to target
            600     // Ramp time: 10 minutes
        );
        protocol.stages.push_back(preheat);

        // Stage 2: Culture (indefinite)
        ProtocolManager::ProtocolStage culture(
            "Culture",
            30.0,   // Temperature
            70.0,   // Humidity
            0.04,   // CO2
            0,      // Duration: indefinite
            false,  // No ramping
            0       // No ramp time
        );
        protocol.stages.push_back(culture);

        // Alarm thresholds
        protocol.tempAlarmHigh = 32.0;
        protocol.tempAlarmLow = 28.0;
        protocol.humidityAlarmLow = 60.0;
        protocol.co2AlarmHigh = 1.0;
        protocol.co2AlarmLow = 0.0;

        return protocol;
    }

    /**
     * Template 4: Decontamination Cycle
     * High-temperature cleaning cycle
     * Heat → 65°C for 2 hours → Cool down
     */
    static ProtocolManager::Protocol getDecontaminationProtocol() {
        ProtocolManager::Protocol protocol;
        protocol.type = ProtocolManager::DECONTAMINATION;
        protocol.name = "Decontamination Cycle";
        protocol.description = "High-temperature cleaning cycle (65°C for 2 hours)";

        // Stage 1: Heat-up (30 min ramp to 65°C)
        ProtocolManager::ProtocolStage heatup(
            "Heat-up",
            65.0,   // Temperature (high for decontamination)
            50.0,   // Humidity (moderate)
            0.04,   // CO2 (ambient)
            1800,   // Duration: 30 minutes
            true,   // Ramp to target
            1800    // Ramp time: 30 minutes
        );
        protocol.stages.push_back(heatup);

        // Stage 2: Decontamination (2 hours at 65°C)
        ProtocolManager::ProtocolStage decontaminate(
            "Decontamination",
            65.0,   // Temperature
            50.0,   // Humidity
            0.04,   // CO2
            7200,   // Duration: 2 hours
            false,  // No ramping
            0       // No ramp time
        );
        protocol.stages.push_back(decontaminate);

        // Stage 3: Cool-down (1 hour to ambient)
        ProtocolManager::ProtocolStage cooldown(
            "Cool-down",
            25.0,   // Temperature (ambient)
            50.0,   // Humidity
            0.04,   // CO2
            3600,   // Duration: 1 hour
            true,   // Ramp to target
            3600    // Ramp time: 1 hour
        );
        protocol.stages.push_back(cooldown);

        // Alarm thresholds (wider range for decontamination)
        protocol.tempAlarmHigh = 70.0;
        protocol.tempAlarmLow = 20.0;
        protocol.humidityAlarmLow = 30.0;
        protocol.co2AlarmHigh = 1.0;
        protocol.co2AlarmLow = 0.0;

        return protocol;
    }

    /**
     * Template 5: Multi-Temperature Expression
     * Multi-stage protocol for protein expression studies
     * 30°C (24h) → 37°C (48h) → 25°C (maintenance)
     */
    static ProtocolManager::Protocol getMultiTempExpressionProtocol() {
        ProtocolManager::Protocol protocol;
        protocol.type = ProtocolManager::CUSTOM_PROTOCOL;
        protocol.name = "Multi-Temperature Expression";
        protocol.description = "Three-stage protocol for protein expression optimization";

        // Stage 1: Initial growth (24 hours at 30°C)
        ProtocolManager::ProtocolStage initialGrowth(
            "Initial Growth",
            30.0,   // Temperature
            70.0,   // Humidity
            5.0,    // CO2
            86400,  // Duration: 24 hours
            true,   // Ramp to target
            900     // Ramp time: 15 minutes
        );
        protocol.stages.push_back(initialGrowth);

        // Stage 2: Expression (48 hours at 37°C)
        ProtocolManager::ProtocolStage expression(
            "Expression Phase",
            37.0,   // Temperature
            70.0,   // Humidity
            5.0,    // CO2
            172800, // Duration: 48 hours
            true,   // Ramp to target
            1800    // Ramp time: 30 minutes
        );
        protocol.stages.push_back(expression);

        // Stage 3: Maintenance (indefinite at 25°C)
        ProtocolManager::ProtocolStage maintenance(
            "Maintenance",
            25.0,   // Temperature
            60.0,   // Humidity
            0.04,   // CO2 (ambient)
            0,      // Duration: indefinite
            true,   // Ramp to target
            1800    // Ramp time: 30 minutes
        );
        protocol.stages.push_back(maintenance);

        // Alarm thresholds
        protocol.tempAlarmHigh = 40.0;
        protocol.tempAlarmLow = 23.0;
        protocol.humidityAlarmLow = 55.0;
        protocol.co2AlarmHigh = 6.0;
        protocol.co2AlarmLow = 4.0;

        return protocol;
    }

    /**
     * Get a template by type
     */
    static ProtocolManager::Protocol getTemplate(ProtocolManager::ProtocolType type) {
        switch (type) {
            case ProtocolManager::MAMMALIAN_CULTURE:
                return getMammalianCultureProtocol();
            case ProtocolManager::BACTERIAL_CULTURE:
                return getBacterialGrowthProtocol();
            case ProtocolManager::YEAST_CULTURE:
                return getYeastCultureProtocol();
            case ProtocolManager::DECONTAMINATION:
                return getDecontaminationProtocol();
            case ProtocolManager::CUSTOM_PROTOCOL:
            default:
                return getMultiTempExpressionProtocol();
        }
    }
};

#endif // PROTOCOL_TEMPLATES_H
