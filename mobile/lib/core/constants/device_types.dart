/// Device type enumeration for Axionyx devices
enum DeviceType {
  pcr('PCR', 'PCR Machine'),
  incubator('INCUBATOR', 'Incubator'),
  dummy('DUMMY', 'Dummy Device');

  final String id;
  final String displayName;

  const DeviceType(this.id, this.displayName);

  static DeviceType fromString(String type) {
    switch (type.toUpperCase()) {
      case 'PCR':
        return DeviceType.pcr;
      case 'INCUBATOR':
        return DeviceType.incubator;
      case 'DUMMY':
        return DeviceType.dummy;
      default:
        return DeviceType.dummy;
    }
  }
}

/// Device state enumeration
enum DeviceState {
  idle('IDLE', 'Idle'),
  starting('STARTING', 'Starting'),
  running('RUNNING', 'Running'),
  paused('PAUSED', 'Paused'),
  stopping('STOPPING', 'Stopping'),
  error('ERROR', 'Error'),
  complete('COMPLETE', 'Complete');

  final String id;
  final String displayName;

  const DeviceState(this.id, this.displayName);

  static DeviceState fromString(String state) {
    switch (state.toUpperCase()) {
      case 'IDLE':
        return DeviceState.idle;
      case 'STARTING':
        return DeviceState.starting;
      case 'RUNNING':
        return DeviceState.running;
      case 'PAUSED':
        return DeviceState.paused;
      case 'STOPPING':
        return DeviceState.stopping;
      case 'ERROR':
        return DeviceState.error;
      case 'COMPLETE':
        return DeviceState.complete;
      default:
        return DeviceState.idle;
    }
  }
}

/// PCR phase enumeration
enum PCRPhase {
  idle('IDLE', 'Idle'),
  hotStart('HOT_START', 'Hot Start'),
  initialDenature('INITIAL_DENATURE', 'Initial Denaturation'),
  denature('DENATURE', 'Denaturation'),
  anneal('ANNEAL', 'Annealing'),
  extend('EXTEND', 'Extension'),
  annealExtend('ANNEAL_EXTEND', 'Anneal + Extend'),
  finalExtend('FINAL_EXTEND', 'Final Extension'),
  hold('HOLD', 'Hold'),
  complete('COMPLETE', 'Complete');

  final String id;
  final String displayName;

  const PCRPhase(this.id, this.displayName);

  static PCRPhase fromString(String phase) {
    switch (phase.toUpperCase()) {
      case 'IDLE':
        return PCRPhase.idle;
      case 'HOT_START':
        return PCRPhase.hotStart;
      case 'INITIAL_DENATURE':
        return PCRPhase.initialDenature;
      case 'DENATURE':
        return PCRPhase.denature;
      case 'ANNEAL':
        return PCRPhase.anneal;
      case 'EXTEND':
        return PCRPhase.extend;
      case 'ANNEAL_EXTEND':
        return PCRPhase.annealExtend;
      case 'FINAL_EXTEND':
        return PCRPhase.finalExtend;
      case 'HOLD':
        return PCRPhase.hold;
      case 'COMPLETE':
        return PCRPhase.complete;
      default:
        return PCRPhase.idle;
    }
  }
}

/// Incubator protocol state enumeration
enum ProtocolState {
  idle('IDLE', 'Idle'),
  preheating('PREHEATING', 'Preheating'),
  running('RUNNING', 'Running'),
  paused('PAUSED', 'Paused'),
  complete('COMPLETE', 'Complete');

  final String id;
  final String displayName;

  const ProtocolState(this.id, this.displayName);

  static ProtocolState fromString(String state) {
    switch (state.toUpperCase()) {
      case 'IDLE':
        return ProtocolState.idle;
      case 'PREHEATING':
        return ProtocolState.preheating;
      case 'RUNNING':
        return ProtocolState.running;
      case 'PAUSED':
        return ProtocolState.paused;
      case 'COMPLETE':
        return ProtocolState.complete;
      default:
        return ProtocolState.idle;
    }
  }
}

/// Incubator protocol stage enumeration (for multi-stage protocols)
enum ProtocolStage {
  idle('IDLE', 'Idle'),
  preEquilibration('PRE_EQUILIBRATION', 'Pre-Equilibration'),
  stage1('STAGE_1', 'Stage 1'),
  stage2('STAGE_2', 'Stage 2'),
  stage3('STAGE_3', 'Stage 3'),
  stage4('STAGE_4', 'Stage 4'),
  coolDown('COOL_DOWN', 'Cool Down'),
  complete('COMPLETE', 'Complete');

  final String id;
  final String displayName;

  const ProtocolStage(this.id, this.displayName);

  static ProtocolStage fromString(String stage) {
    switch (stage.toUpperCase()) {
      case 'IDLE':
        return ProtocolStage.idle;
      case 'PRE_EQUILIBRATION':
      case 'PREEQUILIBRATION':
        return ProtocolStage.preEquilibration;
      case 'STAGE_1':
      case 'STAGE1':
        return ProtocolStage.stage1;
      case 'STAGE_2':
      case 'STAGE2':
        return ProtocolStage.stage2;
      case 'STAGE_3':
      case 'STAGE3':
        return ProtocolStage.stage3;
      case 'STAGE_4':
      case 'STAGE4':
        return ProtocolStage.stage4;
      case 'COOL_DOWN':
      case 'COOLDOWN':
        return ProtocolStage.coolDown;
      case 'COMPLETE':
        return ProtocolStage.complete;
      default:
        return ProtocolStage.idle;
    }
  }
}

/// Alarm severity enumeration
enum AlarmSeverity {
  warning(0, 'Warning'),
  critical(1, 'Critical');

  final int level;
  final String displayName;

  const AlarmSeverity(this.level, this.displayName);

  static AlarmSeverity fromLevel(int level) {
    switch (level) {
      case 0:
        return AlarmSeverity.warning;
      case 1:
        return AlarmSeverity.critical;
      default:
        return AlarmSeverity.warning;
    }
  }
}

/// Alarm type enumeration
enum AlarmType {
  tempHigh(0, 'Temperature High'),
  tempLow(1, 'Temperature Low'),
  humidityLow(2, 'Humidity Low'),
  co2High(3, 'CO2 High'),
  co2Low(4, 'CO2 Low'),
  doorOpen(5, 'Door Open'),
  powerFailure(6, 'Power Failure'),
  sensorFault(7, 'Sensor Fault');

  final int id;
  final String displayName;

  const AlarmType(this.id, this.displayName);

  static AlarmType fromId(int id) {
    switch (id) {
      case 0:
        return AlarmType.tempHigh;
      case 1:
        return AlarmType.tempLow;
      case 2:
        return AlarmType.humidityLow;
      case 3:
        return AlarmType.co2High;
      case 4:
        return AlarmType.co2Low;
      case 5:
        return AlarmType.doorOpen;
      case 6:
        return AlarmType.powerFailure;
      case 7:
        return AlarmType.sensorFault;
      default:
        return AlarmType.sensorFault;
    }
  }
}
