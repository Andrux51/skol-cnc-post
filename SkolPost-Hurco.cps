/**
  Copyright (C) 2019-2025 Andy Martin
  All rights reserved.

  FANUC CNC firmware post processor configuration.

  Reference:
   - https://cam.autodesk.com/posts/reference/
   - https://cam.autodesk.com/posts/reference/classPostProcessor.html
   - http://www.helmancnc.com/cnc-machine-g-codes-and-m-codes-cnc-milling-and-lathe/

  Revision History:
   - 2019-05-15: Initial version
   - 2025-08-21: Format with Prettier
   - 2025-08-21: Add support for Manual NC Passthrough
*/

var gcodeFlavor = "fanuc";

description = "Skol Ironworks Custom Post";
vendor = "Fanuc";
vendorUrl = "http://www.fanuc.com";
legal = "Copyright (C) 2019-2025 Andy Martin";
certificationLevel = 2;
minimumRevision = 1;

longDescription = "Custom post for Fanuc firmware made for Skol Ironworks";

extension = "";
programNameIsInteger = true;
setCodePage("ascii");

capabilities = CAPABILITY_MILLING;
tolerance = spatial(0.002, MM);

minimumChordLength = spatial(0.25, MM);
minimumCircularRadius = spatial(0.01, MM);
maximumCircularRadius = spatial(1000, MM);
minimumCircularSweep = toRad(0.01);
maximumCircularSweep = toRad(180);
allowHelicalMoves = true;
allowedCircularPlanes = undefined; // allow any circular motion

// user-defined properties
properties = {
  allow3DArcs: false, // specifies that 3D circular arcs are allowed
  forceIJK: false, // force output of IJK for G2/G3 when not using R word
  o8: false, // specifies 8-digit program number
  optionalStop: false, // optional stop
  preloadTool: true, // preloads next tool on tool change if any
  preloadFirstTool: true,
  separateWordsWithSpace: true, // specifies that the words should be separated with a white space
  sequenceNumberIncrement: 5, // increment for sequence numbers
  sequenceNumberStart: 10, // first sequence number
  showNotes: false, // specifies that operation notes should be output
  showSequenceNumbers: false, // show sequence numbers
  useG28: true, // specifies that G28 should be used instead of G53
  useParametricFeed: false, // specifies that feed should be output using Q values
  usePitchForTapping: false, // enable to use pitch instead of feed for the F-word for canned tapping cycles - note that your CNC control must be setup for pitch mode!
  useRadius: false, // specifies that arcs should be output using the radius (R word) instead of the I, J, and K words
  useRigidTapping: "yes", // output rigid tapping block
  useSubroutines: false, // specifies that subroutines per each operation should be generated
  useSubroutineCycles: false, // generates subroutines for cycle operations on same holes
  useSubroutinePatterns: false, // generates subroutines for patterned operation
  useSmoothing: false, // specifies if smoothing should be used or not
  writeMachine: false, // write machine
  writeTools: true, // writes the tools
  // added by Andy
  endPositionX: 0,
  endPositionY: 0,
  feedrateMode: "minute",
  planeMode: "XY",
  showSectionNumbers: true, // show section numbers
  useWorkpieceSetupErrorCorrection: false, // Fanuc 30i supports G54.4 for Workpiece Error Compensation
};

// user-defined property definitions
propertyDefinitions = {
  writeMachine: {
    title: "Write machine",
    description: "Output the machine settings in the header of the code.",
    group: 0,
    type: "boolean",
  },
  writeTools: {
    title: "Write tool list",
    description: "Output a tool list in the header of the code.",
    group: 0,
    type: "boolean",
  },
  preloadTool: {
    title: "Preload tool",
    description: "Preloads the next tool at a tool change (if any).",
    group: 1,
    type: "boolean",
  },
  showSequenceNumbers: {
    title: "Use sequence numbers",
    description: "Use sequence numbers for each block of outputted code.",
    group: 1,
    type: "boolean",
  },
  sequenceNumberStart: {
    title: "Start sequence number",
    description: "The number at which to start the sequence numbers.",
    group: 1,
    type: "integer",
  },
  sequenceNumberIncrement: {
    title: "Sequence number increment",
    description:
      "The amount by which the sequence number is incremented by in each block.",
    group: 1,
    type: "integer",
  },
  optionalStop: {
    title: "Optional stop",
    description:
      "Outputs optional stop code during when necessary in the code.",
    type: "boolean",
  },
  o8: {
    title: "8 Digit program number",
    description: "Specifies that an 8 digit program number is needed.",
    type: "boolean",
  },
  separateWordsWithSpace: {
    title: "Separate words with space",
    description: "Adds spaces between words if 'yes' is selected.",
    type: "boolean",
  },
  allow3DArcs: {
    title: "Allow 3D arcs",
    description: "Specifies whether 3D circular arcs are allowed.",
    type: "boolean",
  },
  useRadius: {
    title: "Radius arcs",
    description:
      "If yes is selected, arcs are outputted using radius values rather than IJK.",
    type: "boolean",
  },
  forceIJK: {
    title: "Force IJK",
    description: "Force the output of IJK for G2/G3 when not using R mode.",
    type: "boolean",
  },
  useParametricFeed: {
    title: "Parametric feed",
    description:
      "Specifies the feed value that should be output using a Q value.",
    type: "boolean",
  },
  showNotes: {
    title: "Show notes",
    description: "Writes operation notes as comments in the outputted code.",
    type: "boolean",
  },
  useSmoothing: {
    title: "Use smoothing",
    description: "Specifies if smoothing should be used or not.",
    type: "boolean",
  },
  usePitchForTapping: {
    title: "Use pitch for tapping",
    description:
      "Enables the use of pitch instead of feed for the F-word in canned tapping cycles. Your CNC control must be setup for pitch mode!",
    type: "boolean",
  },
  useG95: {
    title: "Use G95",
    description: "Use IPR/MPR instead of IPM/MPM.",
    type: "boolean",
  },
  useG54x4: {
    title: "Use G54.4",
    description: "Fanuc 30i supports G54.4 for workpiece error compensation.",
    type: "boolean",
  },
  useSubroutines: {
    title: "Use subroutines",
    description:
      "Specifies that subroutines per each operation should be generated.",
    type: "boolean",
  },
  useSubroutinePatterns: {
    title: "Use subroutine patterns",
    description: "Generates subroutines for patterned operation.",
    type: "boolean",
  },
  useSubroutineCycles: {
    title: "Use subroutine cycles",
    description: "Generates subroutines for cycle operations on same holes.",
    type: "boolean",
  },
  useG28: {
    title: "G28 Safe retracts",
    description: "Disable to use G53 instead of G28 for retracts.",
    type: "boolean",
  },
  useRigidTapping: {
    title: "Use rigid tapping",
    description:
      "Select 'Yes' to enable, 'No' to disable, or 'Without spindle direction' to enable rigid tapping without outputting the spindle direction block.",
    type: "enum",
    values: [
      { title: "Yes", id: "yes" },
      { title: "No", id: "no" },
      { title: "Without spindle direction", id: "without" },
    ],
  },
  // added by Andy
  preloadFirstTool: {
    title: "Preload first tool",
    description: "Preloads the first tool after last tool change.",
    group: 1,
    type: "boolean",
  },
  endPositionX: {
    title: "End Position X",
    description: "X position to move toolhead when job finishes.",
    type: "integer",
  },
  endPositionY: {
    title: "End Position Y",
    description: "Y position to move toolhead when job finishes.",
    type: "integer",
  },
  feedrateMode: {
    title: "Feedrate mode",
    description:
      "Choose between using feedrates in mm/inch per minute, or per revolution",
    type: "enum",
    values: [
      { title: "Per Minute", id: "minute" },
      { title: "Per Revolution", id: "revolution" },
    ],
  },
  planeMode: {
    title: "Plane mode",
    description: "Primary (bed) plane directions",
    type: "enum",
    values: [
      { title: "XY", id: "XY" },
      { title: "ZX", id: "ZX" },
      { title: "YZ", id: "YZ" },
    ],
  },
  showSectionNumbers: {
    title: "Use section numbers",
    description:
      "Number the beginning of each operation section to enhance search ability. Disable Sequence Numbers below to reduce noise.",
    group: 1,
    type: "boolean",
  },
  useWorkpieceSetupErrorCorrection: {
    title: "Use Workpiece Setup Error Correction",
    description: "Fanuc 30i supports G54.4 for workpiece error compensation.",
    type: "boolean",
  },
};

// samples:
// throughTool: {on: 88, off: 89}
// throughTool: {on: [8, 88], off: [9, 89]}
var coolants = {
  flood: { on: 8 },
  mist: {},
  throughTool: { on: 7, off: 9 },
  air: {},
  airThroughTool: {},
  suction: {},
  floodMist: {},
  floodThroughTool: { on: [8, 7], off: [9, 89] },
  off: 9,
};

var permittedCommentChars = " ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,=_-";

var gFormat = createFormat({
  prefix: "G",
  width: 2,
  zeropad: true,
  decimals: 1,
});
var mFormat = createFormat({
  prefix: "M",
  width: 2,
  zeropad: true,
  decimals: 1,
});
var nFormat = createFormat({ prefix: "N" });
var hFormat = createFormat({
  prefix: "H",
  width: 2,
  zeropad: true,
  decimals: 1,
});
var dFormat = createFormat({
  prefix: "D",
  width: 2,
  zeropad: true,
  decimals: 1,
});
var probe100Format = createFormat({
  decimals: 3,
  zeropad: true,
  width: 3,
  forceDecimal: true,
});

var xyzFormat = createFormat({
  decimals: unit == MM ? 3 : 4,
  forceDecimal: true,
});
var ijkFormat = createFormat({ decimals: 6, forceDecimal: true }); // unitless
var rFormat = xyzFormat; // radius
var abcFormat = createFormat({ decimals: 3, forceDecimal: true, scale: DEG });
var feedFormat = createFormat({
  decimals: unit == MM ? 0 : 1,
  forceDecimal: true,
});
var pitchFormat = createFormat({
  decimals: unit == MM ? 3 : 4,
  forceDecimal: true,
});
var toolFormat = createFormat({ prefix: "T", decimals: 0 });
var rpmFormat = createFormat({ decimals: 0 });
var secFormat = createFormat({ decimals: 3, forceDecimal: true }); // seconds - range 0.001-99999.999
var milliFormat = createFormat({ decimals: 0 }); // milliseconds // range 1-9999
var taperFormat = createFormat({ decimals: 1, scale: DEG });
var //oFormat = createFormat({width:4, zeropad:true, decimals:0});
  oFormat = createFormat({
    width: properties.o8 ? 8 : 4,
    zeropad: true,
    decimals: 0,
  });

var xOutput = createVariable({ prefix: "X" }, xyzFormat);
var yOutput = createVariable({ prefix: "Y" }, xyzFormat);
var zOutput = createVariable(
  {
    onchange: function () {
      retracted = false;
    },
    prefix: "Z",
  },
  xyzFormat
);
var aOutput = createVariable({ prefix: "A" }, abcFormat);
var bOutput = createVariable({ prefix: "B" }, abcFormat);
var cOutput = createVariable({ prefix: "C" }, abcFormat);
var feedOutput = createVariable({ prefix: "F" }, feedFormat);
var pitchOutput = createVariable({ prefix: "F", force: true }, pitchFormat);
var sOutput = createVariable({ prefix: "S", force: true }, rpmFormat);
var dOutput = createVariable({}, dFormat);

// circular output
var iOutput = createReferenceVariable({ prefix: "I" }, xyzFormat);
var jOutput = createReferenceVariable({ prefix: "J" }, xyzFormat);
var kOutput = createReferenceVariable({ prefix: "K" }, xyzFormat);

var gMotionModal = createModal({}, gFormat); // modal group 1 // G0-G3, ...
var gPlaneModal = createModal(
  {
    onchange: function () {
      gMotionModal.reset();
    },
  },
  gFormat
); // modal group 2 // G17-19
var gAbsIncModal = createModal({}, gFormat); // modal group 3 // G90-91
var gFeedModeModal = createModal({}, gFormat); // modal group 5 // G94-95
var gUnitModal = createModal({}, gFormat); // modal group 6 // G20-21
var gCycleModal = createModal({}, gFormat); // modal group 9 // G81, ...
var gRetractModal = createModal({}, gFormat); // modal group 10 // G98-99
var gRotationModal = createModal({}, gFormat); // modal group 16 // G68-G69

// fixed settings
var firstFeedParameter = 500;
var useMultiAxisFeatures = true;
var forceMultiAxisIndexing = false; // force multi-axis indexing for 3D programs
var maximumLineLength = 80; // the maximum number of charaters allowed in a line
var minimumCyclePoints = 5; // minimum number of points in cycle operation to consider for subprogram
var cancelTiltFirst = false; // cancel G68.2 with G69 prior to G54-G59 WCS block
var useABCPrepositioning = false; // position ABC axes prior to G68.2 block

var WARNING_WORK_OFFSET = 0;

var ANGLE_PROBE_NOT_SUPPORTED = 0;
var ANGLE_PROBE_USE_ROTATION = 1;
var ANGLE_PROBE_USE_CAXIS = 2;

var SUB_UNKNOWN = 0;
var SUB_PATTERN = 1;
var SUB_CYCLE = 2;

var FIRST_SECTION_NUMBER = 1;

// raw g-code numbers
var GCODES = {
  MOVE_RAPID: 0,
  MOVE_LINEAR: 1,
  MOVE_ARC_CW: 2,
  MOVE_ARC_CCW: 3,
  DWELL: 4,
  LOOKAHEAD: 5.1,
  PLANE_MODE_XY: 17,
  PLANE_MODE_ZX: 18,
  PLANE_MODE_YZ: 19,
  UNITS_IN: 20, // default in 'murica
  UNITS_MM: 21, // the rest of the fucking planet- better resolution possible (0.0001" increments are larger than 0.001mm)
  HOMING: 28,
  THREAD_CUTTING: 32,
  TOOL_RADIUS_COMP_OFF: 40, // cancel G41 or G42
  TOOL_RADIUS_COMP_LEFT: 41, // the technical term for this is CRC (calculated radius something something)
  TOOL_RADIUS_COMP_RIGHT: 42, // basically, an offset to make up for the tool's radius
  TOOL_HEIGHT_OFFSET_COMP_NEG: 43, // ball nose tools are fucking stupid for this
  TOOL_HEIGHT_OFFSET_COMP_POS: 44, // but CAM software does all the work anyway so yeet
  TOOL_LENGTH_OFFSET_COMP_CANCEL: 49, // cancel G43 or G44
  WORKPIECE_SETUP_ERROR_CORRECTION: 54.4, // https://www.scribd.com/document/335554791/G54-4-Workpiece-Setup-Error-Correction
  ROTATE_COORDINATE_SYSTEM: 68, // rotate coordinate system in the current plane given with G17, G18, G19
  ROTATE_COORDINATE_SYSTEM_DISABLE: 69,
  CANCEL_CANNED_CYCLE: 80, // cancels all cycles such as G73, G81, G83, etc
  MOVEMENT_MODE_ABSOLUTE: 90, // all coordinates taken as absolute values away from position 0
  MOVEMENT_MODE_INCREMENTAL: 91, // incremental / relative mode - all coordinates taken as distance from toolhead
  FEEDRATE_PER_MINUTE: 94, // feedrate mode
  FEEDRATE_PER_REVOLUTION: 95, // feedrate mode
};

// raw m-code numbers
// note: many m-codes are provided by the API as COMMAND_xxx
var MCODES = {
  END_OF_PROGRAM: 2,
  STOP_SPINDLE: 5,
  COOLANT_OFF: 9,
  PROGRAM_END: 30, // considered the standard program-end code, this also returns execution to the top of the program
};

var SECTIONS = {
  CURRENT: 0,
  PREVIOUS: 1,
  NEXT: 2,
};

// collected state
var sequenceNumber;
var sectionNumber;
var currentWorkOffset;
var optionalSection = false;
var forceSpindleSpeed = false;
var activeMovements; // do not use by default
var currentFeedId;
var g68RotationMode = 0;
var angularProbingMode;
var subprograms = [];
var currentPattern = -1;
var firstPattern = false;
var currentSubprogram;
var lastSubprogram;
var definedPatterns = new Array();
var incrementalMode = false;
var saveShowSequenceNumbers;
var cycleSubprogramIsActive = false;
var patternIsActive = false;
var lastOperationComment = "";

var lengthCompensationActive = false;
var retracted = false; // specifies that the tool has been retracted to the safe plane

var currentSmoothing = false;

// NOTE: comes right before the first "section"
function onOpen() {
  // #region error checking
  // error out if settings are bad
  if (errorFeedrateConfig()) return;

  // presumably, this would be flagged by a setting that is not implemented
  if (false) {
    // error out if any tool numbers are duplicates
    if (errorDuplicateToolNumbers()) return;
  }

  // error out if initial work offset is 0 and multiple offsets exist
  if (errorOffsetConfig()) return;
  // #endregion

  // #region Set defaults based on config properties
  sequenceNumber = properties.sequenceNumberStart;
  sectionNumber = FIRST_SECTION_NUMBER;

  gRotationModal.format(GCODES.ROTATE_COORDINATE_SYSTEM_DISABLE);

  if (properties.feedrateMode === "revolution") {
    feedFormat = createFormat({
      decimals: unit == MM ? 4 : 5,
      forceDecimal: true,
    });
    feedOutput = createVariable({ prefix: "F" }, feedFormat);
  }

  if (properties.useRadius) {
    maximumCircularSweep = toRad(90); // avoid potential center calculation errors for CNC
  }

  // note: setup your machine here
  // presumably, this would be flagged by a setting that is not implemented
  if (false) {
    machineConfiguration = setupManyAxisMachine();
  }

  if (!machineConfiguration.isMachineCoordinate(0)) {
    aOutput.disable();
  }
  if (!machineConfiguration.isMachineCoordinate(1)) {
    bOutput.disable();
  }
  if (!machineConfiguration.isMachineCoordinate(2)) {
    cOutput.disable();
  }

  if (!properties.separateWordsWithSpace) {
    setWordSeparator("");
  }

  if (properties.forceIJK) {
    iOutput = createReferenceVariable({ prefix: "I", force: true }, xyzFormat);
    jOutput = createReferenceVariable({ prefix: "J", force: true }, xyzFormat);
    kOutput = createReferenceVariable({ prefix: "K", force: true }, xyzFormat);
  }
  // #endregion

  // #region Actual GCode writing begins
  writeln("%");

  if (programName) {
    writeProgramName();
  } else {
    error(localize("Program name has not been specified."));
    return;
  }

  if (properties.writeMachine) {
    writeMachineInfo(machineConfiguration);
  }

  // dump tool information
  if (properties.writeTools) {
    writeToolsInfo();
  }
  // #endregion
}

// NOTE: comes right after the last "section"
function onClose() {
  optionalSection = false;

  // writeLineBreak();

  // ignored on machines with less than 4 axes
  setWorkPlane(new Vector(0, 0, 0)); // reset working plane

  if (properties.useWorkpieceSetupErrorCorrection) {
    writeBlock(gCode(GCODES.WORKPIECE_SETUP_ERROR_CORRECTION), "P0");
  }

  // TODO: I would probably do this differently.
  // something like this might make more sense: G28 Z Y
  // true homing shouldn't be too concerned about absolute/incremental movement
  // this is also a good place to enact the endPositionX and endPositionY properties
  // to allow customization for where the axes will be at the end of work piece
  // e.g. on my 3d printer, I end Y at max to get the piece out from under the toolhead
  // -AM 05152019
  writeRetract(Y); // return to home Josh

  // Process Manual NC commands
  executeManualNC();

  // M02 followed by M30 should be enough to make sure the machine stops good and dead
  // writeBlock(mCode(MCODES.END_OF_PROGRAM))
  writeBlock(mCode(MCODES.PROGRAM_END)); // stop program, spindle stop, coolant off

  // NOTE: It will start adding subprograms immediately after program end
  if (subprograms.length > 0) {
    writeLineBreak();
    write(subprograms);
  }

  writeln("%"); // EOF (end of file)
}

// An NC section. A section is a group of NC data which shares the same work plane, tool, and related data.
function onSection() {
  // NOTE: some values can be initialized meaningfully for first section or based on parameter
  var zIsOutput = false; // true if the Z-position has been output, used for patterns
  var newWorkOffset = isFirstSection();
  var newWorkPlane = isFirstSection();
  var forceSmoothing =
    properties.useSmoothing && parameterEq("operation-strategy", "drill");
  var hasPreviousSection = isFirstSection() ? false : true;

  // #region flags that define a "new tooling" type of scenario
  var forceToolAndRetract = optionalSection && !currentSection.isOptional();
  optionalSection = currentSection.isOptional();

  var toolChanged = forceToolAndRetract || isFirstSection();

  if (!isFirstSection()) {
    toolChanged =
      (currentSection.getForceToolChange &&
        currentSection.getForceToolChange()) ||
      tool.number != getPreviousSection().getTool().number;

    newWorkOffset =
      getPreviousSection().workOffset != currentSection.workOffset;

    // force new work plane between indexing and simultaneous operations
    newWorkPlane =
      !isSameDirection(
        getPreviousSection().getGlobalFinalToolAxis(),
        currentSection.getGlobalInitialToolAxis()
      ) ||
      (currentSection.isOptimizedForMachine() &&
        getPreviousSection().isOptimizedForMachine() &&
        Vector.diff(
          getPreviousSection().getFinalToolAxisABC(),
          currentSection.getInitialToolAxisABC()
        ).length > 1e-4) ||
      (!machineConfiguration.isMultiAxisConfiguration() &&
        currentSection.isMultiAxis()) ||
      (!getPreviousSection().isMultiAxis() && currentSection.isMultiAxis());

    // force smoothing in case !toolChanged (2d chamfer)
    forceSmoothing =
      forceSmoothing ||
      parameterEq("operation-strategy", "drill", SECTIONS.PREVIOUS);
    // #endregion
  }

  if (toolChanged) {
    // new line at the beginning of every section, regardless of "operation comment" param
    writeLineBreak();

    // add N## to start of new section
    writeSectionNumber();
  }

  // looks like (DRILL4 __ T2 __ .250x90)
  writeToolComment();

  // arbitrary notes added to CAM process
  writeNotes();

  if (toolChanged) {
    // SAFETY BLOCK: G20 G90 G94 G17 G49 G40 G80
    writeSafeBlock();
  }

  if (toolChanged || newWorkOffset || newWorkPlane || forceSmoothing) {
    writeRetract(Z);
    resetXYZOutput();

    if ((toolChanged && !isFirstSection()) || forceSmoothing) {
      disableLengthCompensation();
      setSmoothing(false);
    }

    if (!isFirstSection() && properties.optionalStop) {
      onCommand(COMMAND_OPTIONAL_STOP);
    }
  }

  if (toolChanged) {
    forceWorkPlane();

    if (tool.number > 99) {
      warning(localize("Tool number exceeds maximum value."));
    }

    // NOTE: do actual change to new tool
    writeBlock(toolFormat.format(tool.number), mFormat.format(6));

    // TODO: remove? even if this existed, it'd probably be useless
    //       because this information is shown in writeToolsInfo()
    if (properties.showToolZMin) {
      if (is3D()) {
        var numberOfSections = getNumberOfSections();
        var zRange = currentSection.getGlobalZRange();
        var number = tool.number;
        for (var i = currentSection.getId() + 1; i < numberOfSections; ++i) {
          var section = getSection(i);
          if (section.getTool().number != number) {
            break;
          }
          zRange.expandToRange(section.getGlobalZRange());
        }
        writeComment(localize("ZMIN") + "=" + zRange.getMinimum());
      }
    }

    if (properties.preloadTool) {
      var nextTool = getNextTool(tool.number);
      if (nextTool) {
        writeBlock(
          toolFormat.format(nextTool.number),
          formatComment("preload")
        );
      } else {
        if (properties.preloadFirstTool) {
          var firstToolNumber = getSection(0).getTool().number;
          if (tool.number != firstToolNumber) {
            writeBlock(
              toolFormat.format(firstToolNumber),
              formatComment("preload")
            );
          }
        }
      }
    }
  }

  if (
    !isProbeOperation() &&
    (toolChanged ||
      forceSpindleSpeed ||
      isFirstSection() ||
      rpmFormat.areDifferent(spindleSpeed, sOutput.getCurrent()) ||
      (hasPreviousSection &&
        tool.clockwise != getPreviousSection().getTool().clockwise))
  ) {
    forceSpindleSpeed = false;

    if (spindleSpeed < 1) {
      error(localize("Spindle speed out of range."));
      return;
    }
    if (spindleSpeed > 99999) {
      warning(localize("Spindle speed exceeds maximum value."));
    }

    var tapping =
      parameterEq("operation:cycleType", "tapping") ||
      parameterEq("operation:cycleType", "right-tapping") ||
      parameterEq("operation:cycleType", "left-tapping") ||
      parameterEq("operation:cycleType", "tapping-with-chip-breaking");
    if (!tapping || (tapping && !(properties.useRigidTapping == "without"))) {
      writeBlock(
        sOutput.format(spindleSpeed),
        mFormat.format(tool.clockwise ? 3 : 4)
      );
    }

    onCommand(COMMAND_START_CHIP_TRANSPORT);
    if (
      forceMultiAxisIndexing ||
      !is3D() ||
      machineConfiguration.isMultiAxisConfiguration()
    ) {
      // writeBlock(mFormat.format(xxx)); // shortest path traverse
    }

    currentWorkOffset = undefined;
  }

  // wcs
  var workOffset = currentSection.workOffset;
  if (workOffset == 0) {
    warningOnce(
      localize("Work offset has not been specified. Using G54 as WCS."),
      WARNING_WORK_OFFSET
    );
    workOffset = 1;
  }
  if (workOffset != currentWorkOffset) {
    if (cancelTiltFirst) {
      cancelWorkPlane();
    }
    forceWorkPlane();
  }
  if (workOffset > 0) {
    if (workOffset > 6) {
      var p = workOffset - 6; // 1->...
      if (p > 300) {
        error(localize("Work offset out of range."));
        return;
      } else {
        if (workOffset != currentWorkOffset) {
          writeBlock(gCode(54.1), "P" + p); // G54.1P
          currentWorkOffset = workOffset;
        }
      }
    } else {
      if (workOffset != currentWorkOffset) {
        writeBlock(gCode(53 + workOffset)); // G54->G59
        currentWorkOffset = workOffset;
      }
    }
  }

  resetXYZOutput();

  var abc = defineWorkPlane(currentSection, true);

  // set coolant after we have positioned at Z
  // setCoolant(tool.coolant);

  // Process Pass Through commands
  executeManualNC();

  if (properties.useSmoothing) {
    if (
      hasParameter("operation-strategy") &&
      getParameter("operation-strategy") != "drill"
    ) {
      if (setSmoothing(true)) {
        // we force G43 using lengthCompensationActive
      }
    } else {
      if (setSmoothing(false)) {
        // we force G43 using lengthCompensationActive
      }
    }
  }

  resetAxisOutputs();
  gMotionModal.reset();

  var initialPosition = getFramePosition(currentSection.getInitialPosition());
  if (!retracted && !toolChanged) {
    if (getCurrentPosition().z < initialPosition.z) {
      writeBlock(
        gMotionModal.format(GCODES.MOVE_RAPID),
        zOutput.format(initialPosition.z)
      );
      zIsOutput = true;
    }
  }

  if (
    toolChanged ||
    !lengthCompensationActive ||
    retracted ||
    (hasPreviousSection && getPreviousSection().isMultiAxis())
  ) {
    var lengthOffset = tool.lengthOffset;
    if (lengthOffset > 99) {
      error(localize("Length offset out of range."));
      return;
    }

    gMotionModal.reset();
    writeBlock(gPlaneModal.format(17));

    // cancel compensation prior to enabling it, required when switching G43/G43.4 modes
    // disableLengthCompensation();

    // assumes a Head configuration uses TCP on a Fanuc controller
    var offsetCode = 43;
    if (currentSection.isMultiAxis()) {
      if (
        machineConfiguration.isMultiAxisConfiguration() &&
        currentSection.getOptimizedTCPMode() == 0
      ) {
        offsetCode = 43.4;
      } else if (!machineConfiguration.isMultiAxisConfiguration()) {
        offsetCode = 43.5;
      }
    }

    if (!machineConfiguration.isHeadConfiguration()) {
      writeBlock(
        gAbsIncModal.format(GCODES.MOVEMENT_MODE_ABSOLUTE),
        gMotionModal.format(GCODES.MOVE_RAPID),
        xOutput.format(initialPosition.x),
        yOutput.format(initialPosition.y)
      );
      writeBlock(
        gMotionModal.format(GCODES.MOVE_RAPID),
        gCode(offsetCode),
        zOutput.format(initialPosition.z),
        hFormat.format(lengthOffset)
      );
      lengthCompensationActive = true;
    } else {
      writeBlock(
        gAbsIncModal.format(GCODES.MOVEMENT_MODE_ABSOLUTE),
        gMotionModal.format(GCODES.MOVE_RAPID),
        gCode(offsetCode),
        xOutput.format(initialPosition.x),
        yOutput.format(initialPosition.y),
        zOutput.format(initialPosition.z),
        hFormat.format(lengthOffset)
      );
      lengthCompensationActive = true;
    }
    zIsOutput = true;

    // NOTE: set coolant after G43 offset stuff
    setCoolant(tool.coolant);

    gMotionModal.reset();
  } else {
    writeBlock(
      gAbsIncModal.format(GCODES.MOVEMENT_MODE_ABSOLUTE),
      gMotionModal.format(GCODES.MOVE_RAPID),
      xOutput.format(initialPosition.x),
      yOutput.format(initialPosition.y)
    );
  }

  // validate(lengthCompensationActive, "Length compensation is not active.");

  if (
    properties.useParametricFeed &&
    hasParameter("operation-strategy") &&
    getParameter("operation-strategy") != "drill" && // legacy
    !(currentSection.hasAnyCycle && currentSection.hasAnyCycle())
  ) {
    if (
      !toolChanged &&
      activeMovements &&
      getCurrentSectionId() > 0 &&
      hasPreviousSection &&
      getPreviousSection().getPatternId() == currentSection.getPatternId() &&
      currentSection.getPatternId() != 0
    ) {
      // use the current feeds
    } else {
      initializeActiveFeeds();
    }
  } else {
    activeMovements = undefined;
  }

  if (isProbeOperation()) {
    if (g68RotationMode != 0) {
      error(localize("You cannot probe while G68 Rotation is in effect."));
      return;
    }
    angularProbingMode = getAngularProbingMode();
    writeBlock(gCode(65), "P" + 9832); // spin the probe on
  }

  // define subprogram
  subprogramDefine(initialPosition, abc, retracted, zIsOutput);

  retracted = false;
}

/** Disables length compensation if currently active or if forced. */
function disableLengthCompensation(force) {
  if (lengthCompensationActive || force) {
    validate(
      retracted,
      "Cannot cancel length compensation if the machine is not fully retracted."
    );
    writeBlock(gCode(GCODES.TOOL_LENGTH_OFFSET_COMP_CANCEL));
    lengthCompensationActive = false;
  }
}

function setSmoothing(mode) {
  if (mode == currentSmoothing) {
    return false;
  }

  // 1) Make sure G49 is called before the execution of G05.1 Q1 Rx
  // 2) G05.1 Q1 Rx must be engaged BEFORE G43-Tool Length Comp
  // 3) AICC and AIAPC need to be turned on and off for each tool
  // 4) AICC and AIAPC does not apply to canned drilling cycles
  validate(
    !lengthCompensationActive,
    "Length compensation is active while trying to update smoothing."
  );

  currentSmoothing = mode;
  writeBlock(gCode(GCODES.LOOKAHEAD), mode ? "Q1" : "Q0");
  return true;
}

function FeedContext(id, description, feed) {
  this.id = id;
  this.description = description;
  this.feed = feed;
}

function getFeed(f) {
  if (properties.feedrateMode === "revolution") {
    return feedOutput.format(f / spindleSpeed); // use feed value
  }
  if (activeMovements) {
    var feedContext = activeMovements[movement];
    if (feedContext != undefined) {
      if (!feedFormat.areDifferent(feedContext.feed, f)) {
        if (feedContext.id == currentFeedId) {
          return ""; // nothing has changed
        }
        resetFeedOutput();
        currentFeedId = feedContext.id;
        return "F#" + (firstFeedParameter + feedContext.id);
      }
    }
    currentFeedId = undefined; // force Q feed next time
  }
  return feedOutput.format(f); // use feed value
}

function initializeActiveFeeds() {
  activeMovements = new Array();
  var movements = currentSection.getMovements();

  var id = 0;
  var activeFeeds = new Array();
  if (hasParameter("operation:tool_feedCutting")) {
    if (
      movements &
      ((1 << MOVEMENT_CUTTING) |
        (1 << MOVEMENT_LINK_TRANSITION) |
        (1 << MOVEMENT_EXTENDED))
    ) {
      var feedContext = new FeedContext(
        id,
        localize("Cutting"),
        getParameter("operation:tool_feedCutting")
      );
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_CUTTING] = feedContext;
      activeMovements[MOVEMENT_LINK_TRANSITION] = feedContext;
      activeMovements[MOVEMENT_EXTENDED] = feedContext;
    }
    ++id;
    if (movements & (1 << MOVEMENT_PREDRILL)) {
      feedContext = new FeedContext(
        id,
        localize("Predrilling"),
        getParameter("operation:tool_feedCutting")
      );
      activeMovements[MOVEMENT_PREDRILL] = feedContext;
      activeFeeds.push(feedContext);
    }
    ++id;
  }

  if (hasParameter("operation:finishFeedrate")) {
    if (movements & (1 << MOVEMENT_FINISH_CUTTING)) {
      var feedContext = new FeedContext(
        id,
        localize("Finish"),
        getParameter("operation:finishFeedrate")
      );
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_FINISH_CUTTING] = feedContext;
    }
    ++id;
  } else if (hasParameter("operation:tool_feedCutting")) {
    if (movements & (1 << MOVEMENT_FINISH_CUTTING)) {
      var feedContext = new FeedContext(
        id,
        localize("Finish"),
        getParameter("operation:tool_feedCutting")
      );
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_FINISH_CUTTING] = feedContext;
    }
    ++id;
  }

  if (hasParameter("operation:tool_feedEntry")) {
    if (movements & (1 << MOVEMENT_LEAD_IN)) {
      var feedContext = new FeedContext(
        id,
        localize("Entry"),
        getParameter("operation:tool_feedEntry")
      );
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LEAD_IN] = feedContext;
    }
    ++id;
  }

  if (hasParameter("operation:tool_feedExit")) {
    if (movements & (1 << MOVEMENT_LEAD_OUT)) {
      var feedContext = new FeedContext(
        id,
        localize("Exit"),
        getParameter("operation:tool_feedExit")
      );
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LEAD_OUT] = feedContext;
    }
    ++id;
  }

  if (hasParameter("operation:noEngagementFeedrate")) {
    if (movements & (1 << MOVEMENT_LINK_DIRECT)) {
      var feedContext = new FeedContext(
        id,
        localize("Direct"),
        getParameter("operation:noEngagementFeedrate")
      );
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LINK_DIRECT] = feedContext;
    }
    ++id;
  } else if (
    hasParameter("operation:tool_feedCutting") &&
    hasParameter("operation:tool_feedEntry") &&
    hasParameter("operation:tool_feedExit")
  ) {
    if (movements & (1 << MOVEMENT_LINK_DIRECT)) {
      var feedContext = new FeedContext(
        id,
        localize("Direct"),
        Math.max(
          getParameter("operation:tool_feedCutting"),
          getParameter("operation:tool_feedEntry"),
          getParameter("operation:tool_feedExit")
        )
      );
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LINK_DIRECT] = feedContext;
    }
    ++id;
  }

  if (hasParameter("operation:reducedFeedrate")) {
    if (movements & (1 << MOVEMENT_REDUCED)) {
      var feedContext = new FeedContext(
        id,
        localize("Reduced"),
        getParameter("operation:reducedFeedrate")
      );
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_REDUCED] = feedContext;
    }
    ++id;
  }

  if (hasParameter("operation:tool_feedRamp")) {
    if (
      movements &
      ((1 << MOVEMENT_RAMP) |
        (1 << MOVEMENT_RAMP_HELIX) |
        (1 << MOVEMENT_RAMP_PROFILE) |
        (1 << MOVEMENT_RAMP_ZIG_ZAG))
    ) {
      var feedContext = new FeedContext(
        id,
        localize("Ramping"),
        getParameter("operation:tool_feedRamp")
      );
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_RAMP] = feedContext;
      activeMovements[MOVEMENT_RAMP_HELIX] = feedContext;
      activeMovements[MOVEMENT_RAMP_PROFILE] = feedContext;
      activeMovements[MOVEMENT_RAMP_ZIG_ZAG] = feedContext;
    }
    ++id;
  }
  if (hasParameter("operation:tool_feedPlunge")) {
    if (movements & (1 << MOVEMENT_PLUNGE)) {
      var feedContext = new FeedContext(
        id,
        localize("Plunge"),
        getParameter("operation:tool_feedPlunge")
      );
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_PLUNGE] = feedContext;
    }
    ++id;
  }
  if (true) {
    // high feed
    if (movements & (1 << MOVEMENT_HIGH_FEED)) {
      var feedContext = new FeedContext(
        id,
        localize("High Feed"),
        this.highFeedrate
      );
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_HIGH_FEED] = feedContext;
    }
    ++id;
  }

  for (var i = 0; i < activeFeeds.length; ++i) {
    var feedContext = activeFeeds[i];
    writeBlock(
      "#" +
        (firstFeedParameter + feedContext.id) +
        "=" +
        feedFormat.format(feedContext.feed),
      formatComment(feedContext.description)
    );
  }
}

var currentWorkPlaneABC = undefined;

function forceWorkPlane() {
  currentWorkPlaneABC = undefined;
}

function defineWorkPlane(_section, _setWorkPlane) {
  var abc = new Vector(0, 0, 0);
  if (
    forceMultiAxisIndexing ||
    !is3D() ||
    machineConfiguration.isMultiAxisConfiguration()
  ) {
    // use 5-axis indexing for multi-axis mode
    // set working plane after datum shift

    if (_section.isMultiAxis()) {
      cancelTransformation();
      if (_setWorkPlane) {
        forceWorkPlane();
      }
      if (machineConfiguration.isMultiAxisConfiguration()) {
        abc = _section.getInitialToolAxisABC();
        if (_setWorkPlane) {
          onCommand(COMMAND_UNLOCK_MULTI_AXIS);
          gMotionModal.reset();
          writeBlock(
            gMotionModal.format(GCODES.MOVE_RAPID),
            conditional(
              machineConfiguration.isMachineCoordinate(0),
              "A" + abcFormat.format(abc.x)
            ),
            conditional(
              machineConfiguration.isMachineCoordinate(1),
              "B" + abcFormat.format(abc.y)
            ),
            conditional(
              machineConfiguration.isMachineCoordinate(2),
              "C" + abcFormat.format(abc.z)
            )
          );
        }
      } else {
        var d = currentSection.getGlobalInitialToolAxis();
        // position
        writeBlock(
          gAbsIncModal.format(GCODES.MOVEMENT_MODE_ABSOLUTE),
          gMotionModal.format(GCODES.MOVE_RAPID),
          "I" + xyzFormat.format(d.x),
          "J" + xyzFormat.format(d.y),
          "K" + xyzFormat.format(d.z)
        );
      }
    } else {
      if (useMultiAxisFeatures) {
        var euler = _section.workPlane.getEuler2(EULER_ZXZ_R);
        abc = new Vector(euler.x, euler.y, euler.z);
        cancelTransformation();
      } else {
        abc = getWorkPlaneMachineABC(_section.workPlane, _setWorkPlane, true);
      }
      if (_setWorkPlane) {
        setWorkPlane(abc);
      }
    }
  } else {
    // pure 3D
    var remaining = _section.workPlane;
    if (!isSameDirection(remaining.forward, new Vector(0, 0, 1))) {
      error(localize("Tool orientation is not supported."));
      return abc;
    }
    setRotation(remaining);
  }
  return abc;
}

function cancelWorkPlane() {
  writeBlock(gRotationModal.format(69)); // cancel frame
  forceWorkPlane();
}

function setWorkPlane(abc) {
  if (
    !forceMultiAxisIndexing &&
    is3D() &&
    !machineConfiguration.isMultiAxisConfiguration()
  ) {
    return; // ignore
  }

  if (
    !(
      currentWorkPlaneABC == undefined ||
      abcFormat.areDifferent(abc.x, currentWorkPlaneABC.x) ||
      abcFormat.areDifferent(abc.y, currentWorkPlaneABC.y) ||
      abcFormat.areDifferent(abc.z, currentWorkPlaneABC.z)
    )
  ) {
    return; // no change
  }

  onCommand(COMMAND_UNLOCK_MULTI_AXIS);
  if (!retracted) {
    writeRetract(Z);
  }

  if (useMultiAxisFeatures) {
    if (cancelTiltFirst) {
      cancelWorkPlane();
    }
    if (
      machineConfiguration.isMultiAxisConfiguration() &&
      useABCPrepositioning
    ) {
      var angles = abc.isNonZero()
        ? getWorkPlaneMachineABC(currentSection.workPlane, false)
        : abc;
      gMotionModal.reset();
      writeBlock(
        gMotionModal.format(GCODES.MOVE_RAPID),
        conditional(
          machineConfiguration.isMachineCoordinate(0),
          "A" + abcFormat.format(angles.x)
        ),
        conditional(
          machineConfiguration.isMachineCoordinate(1),
          "B" + abcFormat.format(angles.y)
        ),
        conditional(
          machineConfiguration.isMachineCoordinate(2),
          "C" + abcFormat.format(angles.z)
        )
      );
    }
    if (abc.isNonZero()) {
      gRotationModal.reset();
      writeBlock(
        gRotationModal.format(68.2),
        "X" + xyzFormat.format(0),
        "Y" + xyzFormat.format(0),
        "Z" + xyzFormat.format(0),
        "I" + abcFormat.format(abc.x),
        "J" + abcFormat.format(abc.y),
        "K" + abcFormat.format(abc.z)
      ); // set frame
      writeBlock(gCode(53.1)); // turn machine
    } else {
      if (!cancelTiltFirst) {
        cancelWorkPlane();
      }
    }
  } else {
    gMotionModal.reset();
    writeBlock(
      gMotionModal.format(GCODES.MOVE_RAPID),
      conditional(
        machineConfiguration.isMachineCoordinate(0),
        "A" + abcFormat.format(abc.x)
      ),
      conditional(
        machineConfiguration.isMachineCoordinate(1),
        "B" + abcFormat.format(abc.y)
      ),
      conditional(
        machineConfiguration.isMachineCoordinate(2),
        "C" + abcFormat.format(abc.z)
      )
    );
  }

  onCommand(COMMAND_LOCK_MULTI_AXIS);

  currentWorkPlaneABC = abc;
}

var closestABC = false; // choose closest machine angles
var currentMachineABC;

function getWorkPlaneMachineABC(workPlane, _setWorkPlane, rotate) {
  var W = workPlane; // map to global frame

  var abc = machineConfiguration.getABC(W);
  if (closestABC) {
    if (currentMachineABC) {
      abc = machineConfiguration.remapToABC(abc, currentMachineABC);
    } else {
      abc = machineConfiguration.getPreferredABC(abc);
    }
  } else {
    abc = machineConfiguration.getPreferredABC(abc);
  }

  try {
    abc = machineConfiguration.remapABC(abc);
    if (_setWorkPlane) {
      currentMachineABC = abc;
    }
  } catch (e) {
    error(
      localize("Machine angles not supported") +
        ":" +
        conditional(
          machineConfiguration.isMachineCoordinate(0),
          " A" + abcFormat.format(abc.x)
        ) +
        conditional(
          machineConfiguration.isMachineCoordinate(1),
          " B" + abcFormat.format(abc.y)
        ) +
        conditional(
          machineConfiguration.isMachineCoordinate(2),
          " C" + abcFormat.format(abc.z)
        )
    );
  }

  var direction = machineConfiguration.getDirection(abc);
  if (!isSameDirection(direction, W.forward)) {
    error(localize("Orientation not supported."));
  }

  if (!machineConfiguration.isABCSupported(abc)) {
    error(
      localize("Work plane is not supported") +
        ":" +
        conditional(
          machineConfiguration.isMachineCoordinate(0),
          " A" + abcFormat.format(abc.x)
        ) +
        conditional(
          machineConfiguration.isMachineCoordinate(1),
          " B" + abcFormat.format(abc.y)
        ) +
        conditional(
          machineConfiguration.isMachineCoordinate(2),
          " C" + abcFormat.format(abc.z)
        )
    );
  }

  if (rotate) {
    var tcp = false;
    if (tcp) {
      setRotation(W); // TCP mode
    } else {
      var O = machineConfiguration.getOrientation(abc);
      var R = machineConfiguration.getRemainingOrientation(abc, W);
      setRotation(R);
    }
  }

  return abc;
}

function isProbeOperation() {
  return parameterEq("operation-strategy", "probe");
}

var probeOutputWorkOffset = 1;

/** Returns true if the spatial vectors are significantly different. */
function areSpatialVectorsDifferent(_vector1, _vector2) {
  return (
    xyzFormat.getResultingValue(_vector1.x) !=
      xyzFormat.getResultingValue(_vector2.x) ||
    xyzFormat.getResultingValue(_vector1.y) !=
      xyzFormat.getResultingValue(_vector2.y) ||
    xyzFormat.getResultingValue(_vector1.z) !=
      xyzFormat.getResultingValue(_vector2.z)
  );
}

/** Returns true if the spatial boxes are a pure translation. */
function areSpatialBoxesTranslated(_box1, _box2) {
  return (
    !areSpatialVectorsDifferent(
      Vector.diff(_box1[1], _box1[0]),
      Vector.diff(_box2[1], _box2[0])
    ) &&
    !areSpatialVectorsDifferent(
      Vector.diff(_box2[0], _box1[0]),
      Vector.diff(_box2[1], _box1[1])
    )
  );
}

function subprogramDefine(_initialPosition, _abc, _retracted, _zIsOutput) {
  // convert patterns into subprograms
  var usePattern = false;
  patternIsActive = false;
  if (
    currentSection.isPatterned &&
    currentSection.isPatterned() &&
    properties.useSubroutinePatterns
  ) {
    currentPattern = currentSection.getPatternId();
    firstPattern = true;
    for (var i = 0; i < definedPatterns.length; ++i) {
      if (
        definedPatterns[i].patternType == SUB_PATTERN &&
        currentPattern == definedPatterns[i].patternId
      ) {
        currentSubprogram = definedPatterns[i].subProgram;
        usePattern = definedPatterns[i].validPattern;
        firstPattern = false;
        break;
      }
    }

    if (firstPattern) {
      // determine if this is a valid pattern for creating a subprogram
      usePattern = subprogramIsValid(
        currentSection,
        currentPattern,
        SUB_PATTERN
      );
      if (usePattern) {
        currentSubprogram = ++lastSubprogram;
      }
      definedPatterns.push({
        patternType: SUB_PATTERN,
        patternId: currentPattern,
        subProgram: currentSubprogram,
        validPattern: usePattern,
        initialPosition: _initialPosition,
        finalPosition: _initialPosition,
      });
    }

    if (usePattern) {
      // make sure Z-position is output prior to subprogram call
      if (!_retracted && !_zIsOutput) {
        writeBlock(
          gMotionModal.format(GCODES.MOVE_RAPID),
          zOutput.format(_initialPosition.z)
        );
      }

      // call subprogram
      writeBlock(mFormat.format(98), "P" + oFormat.format(currentSubprogram));
      patternIsActive = true;

      if (firstPattern) {
        subprogramStart(_initialPosition, _abc, true);
      } else {
        skipRemainingSection();
        setCurrentPosition(getFramePosition(currentSection.getFinalPosition()));
      }
    }
  }

  // Output cycle operation as subprogram
  if (
    !usePattern &&
    properties.useSubroutineCycles &&
    currentSection.doesStrictCycle &&
    currentSection.getNumberOfCycles() == 1 &&
    currentSection.getNumberOfCyclePoints() >= minimumCyclePoints
  ) {
    var finalPosition = getFramePosition(currentSection.getFinalPosition());
    currentPattern = currentSection.getNumberOfCyclePoints();
    firstPattern = true;
    for (var i = 0; i < definedPatterns.length; ++i) {
      if (
        definedPatterns[i].patternType == SUB_CYCLE &&
        currentPattern == definedPatterns[i].patternId &&
        !areSpatialVectorsDifferent(
          _initialPosition,
          definedPatterns[i].initialPosition
        ) &&
        !areSpatialVectorsDifferent(
          finalPosition,
          definedPatterns[i].finalPosition
        )
      ) {
        currentSubprogram = definedPatterns[i].subProgram;
        usePattern = definedPatterns[i].validPattern;
        firstPattern = false;
        break;
      }
    }

    if (firstPattern) {
      // determine if this is a valid pattern for creating a subprogram
      usePattern = subprogramIsValid(currentSection, currentPattern, SUB_CYCLE);
      if (usePattern) {
        currentSubprogram = ++lastSubprogram;
      }
      definedPatterns.push({
        patternType: SUB_CYCLE,
        patternId: currentPattern,
        subProgram: currentSubprogram,
        validPattern: usePattern,
        initialPosition: _initialPosition,
        finalPosition: finalPosition,
      });
    }
    cycleSubprogramIsActive = usePattern;
  }

  // Output each operation as a subprogram
  if (!usePattern && properties.useSubroutines) {
    currentSubprogram = ++lastSubprogram;
    writeBlock(mFormat.format(98), "P" + oFormat.format(currentSubprogram));
    firstPattern = true;
    subprogramStart(_initialPosition, _abc, false);
  }
}

function subprogramStart(_initialPosition, _abc, _incremental) {
  redirectToBuffer();
  var comment = "";
  if (hasParameter("operation-comment")) {
    comment = getParameter("operation-comment");
  }
  writeln(
    "O" +
      oFormat.format(currentSubprogram) +
      conditional(
        comment,
        formatComment(comment.substr(0, maximumLineLength - 2 - 6 - 1))
      )
  );
  saveShowSequenceNumbers = properties.showSequenceNumbers;
  properties.showSequenceNumbers = false;
  if (_incremental) {
    setIncrementalMode(_initialPosition, _abc);
  }
  gPlaneModal.reset();
  gMotionModal.reset();
}

function subprogramEnd() {
  if (firstPattern) {
    writeBlock(mFormat.format(99));
    writeLineBreak();
    subprograms += getRedirectionBuffer();
  }
  resetAxisOutputs();
  firstPattern = false;
  properties.showSequenceNumbers = saveShowSequenceNumbers;
  closeRedirection();
}

function subprogramIsValid(_section, _patternId, _patternType) {
  var sectionId = _section.getId();
  var numberOfSections = getNumberOfSections();
  var validSubprogram = _patternType != SUB_CYCLE;

  var masterPosition = new Array();
  masterPosition[0] = getFramePosition(_section.getInitialPosition());
  masterPosition[1] = getFramePosition(_section.getFinalPosition());
  var tempBox = _section.getBoundingBox();
  var masterBox = new Array();
  masterBox[0] = getFramePosition(tempBox[0]);
  masterBox[1] = getFramePosition(tempBox[1]);

  var rotation = getRotation();
  var translation = getTranslation();

  for (var i = 0; i < numberOfSections; ++i) {
    var section = getSection(i);
    if (section.getId() != sectionId) {
      defineWorkPlane(section, false);
      // check for valid pattern
      if (_patternType == SUB_PATTERN) {
        if (section.getPatternId() == _patternId) {
          var patternPosition = new Array();
          patternPosition[0] = getFramePosition(section.getInitialPosition());
          patternPosition[1] = getFramePosition(section.getFinalPosition());
          tempBox = section.getBoundingBox();
          var patternBox = new Array();
          patternBox[0] = getFramePosition(tempBox[0]);
          patternBox[1] = getFramePosition(tempBox[1]);

          if (
            !areSpatialBoxesTranslated(masterPosition, patternPosition) ||
            !areSpatialBoxesTranslated(masterBox, patternBox)
          ) {
            validSubprogram = false;
            break;
          }
        }

        // check for valid cycle operation
      } else if (_patternType == SUB_CYCLE) {
        if (
          section.getNumberOfCyclePoints() == _patternId &&
          section.getNumberOfCycles() == 1
        ) {
          var patternInitial = getFramePosition(section.getInitialPosition());
          var patternFinal = getFramePosition(section.getFinalPosition());
          if (
            !areSpatialVectorsDifferent(patternInitial, masterPosition[0]) &&
            !areSpatialVectorsDifferent(patternFinal, masterPosition[1])
          ) {
            validSubprogram = true;
            break;
          }
        }
      }
    }
  }
  setRotation(rotation);
  setTranslation(translation);
  return validSubprogram;
}

function setIncrementalMode(xyz, abc) {
  xOutput = createIncrementalVariable({ prefix: "X" }, xyzFormat);
  xOutput.format(xyz.x);
  xOutput.format(xyz.x);
  yOutput = createIncrementalVariable({ prefix: "Y" }, xyzFormat);
  yOutput.format(xyz.y);
  yOutput.format(xyz.y);
  zOutput = createIncrementalVariable({ prefix: "Z" }, xyzFormat);
  zOutput.format(xyz.z);
  zOutput.format(xyz.z);
  aOutput = createIncrementalVariable({ prefix: "A" }, abcFormat);
  aOutput.format(abc.x);
  aOutput.format(abc.x);
  bOutput = createIncrementalVariable({ prefix: "B" }, abcFormat);
  bOutput.format(abc.y);
  bOutput.format(abc.y);
  cOutput = createIncrementalVariable({ prefix: "C" }, abcFormat);
  cOutput.format(abc.z);
  cOutput.format(abc.z);
  gAbsIncModal.reset();
  writeBlock(gAbsIncModal.format(91));
  incrementalMode = true;
}

function setAbsoluteMode(xyz, abc) {
  if (incrementalMode) {
    xOutput = createVariable({ prefix: "X" }, xyzFormat);
    xOutput.format(xyz.x);
    yOutput = createVariable({ prefix: "Y" }, xyzFormat);
    yOutput.format(xyz.y);
    zOutput = createVariable({ prefix: "Z" }, xyzFormat);
    zOutput.format(xyz.z);
    aOutput = createVariable({ prefix: "A" }, abcFormat);
    aOutput.format(abc.x);
    bOutput = createVariable({ prefix: "B" }, abcFormat);
    bOutput.format(abc.y);
    cOutput = createVariable({ prefix: "C" }, abcFormat);
    cOutput.format(abc.z);
    gAbsIncModal.reset();
    writeBlock(gAbsIncModal.format(GCODES.MOVEMENT_MODE_ABSOLUTE));
    incrementalMode = false;
  }
}

function onDwell(seconds) {
  if (seconds > 99999.999) {
    warning(localize("Dwelling time is out of range."));
  }
  milliseconds = clamp(1, seconds * 1000, 99999999);
  writeBlock(
    gFeedModeModal.format(GCODES.FEEDRATE_PER_MINUTE),
    gCode(GCODES.DWELL),
    "P" + milliFormat.format(milliseconds)
  );
  writeBlock(
    gFeedModeModal.format(
      properties.feedrateMode === "revolution"
        ? GCODES.FEEDRATE_PER_REVOLUTION
        : GCODES.FEEDRATE_PER_MINUTE
    )
  ); // back to G95
}

function onSpindleSpeed(spindleSpeed) {
  writeBlock(sOutput.format(spindleSpeed));
}

function onCycle() {
  writeBlock(gPlaneModal.format(17));
}

function getCommonCycle(x, y, z, r, c) {
  resetXYZOutput(); // force xyz on first drill hole of any cycle
  if (incrementalMode) {
    zOutput.format(c);
    return [
      xOutput.format(x),
      yOutput.format(y),
      "Z" + xyzFormat.format(z - r),
      "R" + xyzFormat.format(r - c),
    ];
  } else {
    return [
      xOutput.format(x),
      yOutput.format(y),
      zOutput.format(z),
      "R" + xyzFormat.format(r),
    ];
  }
}

function setCyclePosition(_position) {
  switch (gPlaneModal.getCurrent()) {
    case 17: // XY
      zOutput.format(_position);
      break;
    case 18: // ZX
      yOutput.format(_position);
      break;
    case 19: // YZ
      xOutput.format(_position);
      break;
  }
}

/** Convert approach to sign. */
function approach(value) {
  validate(value == "positive" || value == "negative", "Invalid approach.");
  return value == "positive" ? 1 : -1;
}

/**
  Determine if angular probing is supported
*/
function getAngularProbingMode() {
  if (machineConfiguration.isMultiAxisConfiguration()) {
    if (machineConfiguration.isMachineCoordinate(2)) {
      return ANGLE_PROBE_USE_CAXIS;
    } else {
      return ANGLE_PROBE_NOT_SUPPORTED;
    }
  } else {
    return ANGLE_PROBE_USE_ROTATION;
  }
}

/**
  Output rotation offset based on angular probing cycle.
*/
function setProbingAngle() {
  if (g68RotationMode == 1 || g68RotationMode == 2) {
    // Rotate coordinate system for Angle Probing
    if (!properties.useWorkpieceSetupErrorCorrection) {
      gRotationModal.reset();
      gAbsIncModal.reset();
      writeBlock(
        gRotationModal.format(GCODES.ROTATE_COORDINATE_SYSTEM),
        gAbsIncModal.format(GCODES.MOVEMENT_MODE_ABSOLUTE),
        g68RotationMode == 1 ? "X0" : "X[#135]",
        g68RotationMode == 1 ? "Y0" : "Y[#136]",
        "Z0",
        "I0.0",
        "J0.0",
        "K1.0",
        "R[#139]"
      );
      g68RotationMode = 3;
    } else if (angularProbingMode != ANGLE_PROBE_NOT_SUPPORTED) {
      writeBlock("#26010=#135");
      writeBlock("#26011=#136");
      writeBlock("#26012=#137");
      writeBlock("#26015=#139");
      writeBlock(gCode(54.4), "P1");
      g68RotationMode = 0;
    } else {
      error(
        localize(
          "Angular probing is not supported for this machine configuration."
        )
      );
      return;
    }
  }
}

function onCyclePoint(x, y, z) {
  var probeWorkOffsetCode;
  if (isProbeOperation()) {
    if (
      !useMultiAxisFeatures &&
      !isSameDirection(currentSection.workPlane.forward, new Vector(0, 0, 1)) &&
      (!cycle.probeMode || cycle.probeMode == 0)
    ) {
      error(
        localize(
          "Updating WCS / work offset using probing is only supported by the CNC in the WCS frame."
        )
      );
      return;
    }
    var workOffset = probeOutputWorkOffset
      ? probeOutputWorkOffset
      : currentWorkOffset;
    if (workOffset > 99) {
      error(localize("Work offset is out of range."));
      return;
    } else if (workOffset > 6) {
      probeWorkOffsetCode = probe100Format.format(workOffset - 6 + 100);
    } else {
      probeWorkOffsetCode = workOffset + "."; // G54->G59
    }
  }

  if (isFirstCyclePoint()) {
    repositionToCycleClearance(cycle, x, y, z);

    // return to initial Z which is clearance plane and set absolute mode

    var F = cycle.feedrate;
    if (properties.feedrateMode === "revolution") {
      F /= spindleSpeed;
    }
    var P = !cycle.dwell ? 0 : clamp(1, cycle.dwell * 1000, 99999999); // in milliseconds

    var forceCycle = false;
    switch (cycleType) {
      case "drilling":
        writeBlock(
          gRetractModal.format(98),
          gCycleModal.format(81),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          feedOutput.format(F)
        );
        break;
      case "counter-boring":
        if (P > 0) {
          writeBlock(
            gRetractModal.format(98),
            gCycleModal.format(82),
            getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
            "P" + milliFormat.format(P),
            feedOutput.format(F)
          );
        } else {
          writeBlock(
            gRetractModal.format(98),
            gCycleModal.format(81),
            getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
            feedOutput.format(F)
          );
        }
        break;
      case "chip-breaking":
        // cycle.accumulatedDepth is ignored
        if (P > 0) {
          expandCyclePoint(x, y, z);
        } else {
          writeBlock(
            gRetractModal.format(98),
            gCycleModal.format(73),
            getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
            "Q" + xyzFormat.format(cycle.incrementalDepth),
            feedOutput.format(F)
          );
        }
        break;
      case "deep-drilling":
        if (P > 0) {
          expandCyclePoint(x, y, z);
        } else {
          writeBlock(
            gRetractModal.format(98),
            gCycleModal.format(83),
            getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
            "Q" + xyzFormat.format(cycle.incrementalDepth),
            // conditional(P > 0, "P" + milliFormat.format(P)),
            feedOutput.format(F)
          );
        }
        break;
      case "tapping":
        if (properties.useRigidTapping != "no") {
          writeBlock(mFormat.format(29), sOutput.format(spindleSpeed));
        }
        if (properties.usePitchForTapping) {
          writeBlock(
            gRetractModal.format(98),
            gFeedModeModal.format(95),
            gCycleModal.format(tool.type == TOOL_TAP_LEFT_HAND ? 74 : 84),
            getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
            "P" + milliFormat.format(P),
            pitchOutput.format(tool.threadPitch)
          );
          resetFeedOutput();
        } else {
          var tappingFPM =
            tool.getThreadPitch() * rpmFormat.getResultingValue(spindleSpeed);
          F =
            properties.feedrateMode === "revolution"
              ? tool.getThreadPitch()
              : tappingFPM;
          writeBlock(
            gRetractModal.format(98),
            gCycleModal.format(tool.type == TOOL_TAP_LEFT_HAND ? 74 : 84),
            getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
            "P" + milliFormat.format(P),
            feedOutput.format(F)
          );
        }
        break;
      case "left-tapping":
        if (properties.useRigidTapping != "no") {
          writeBlock(mFormat.format(29), sOutput.format(spindleSpeed));
        }
        if (properties.usePitchForTapping) {
          writeBlock(
            gRetractModal.format(98),
            gFeedModeModal.format(95),
            gCycleModal.format(74),
            getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
            "P" + milliFormat.format(P),
            pitchOutput.format(tool.threadPitch)
          );
          resetFeedOutput();
        } else {
          var tappingFPM =
            tool.getThreadPitch() * rpmFormat.getResultingValue(spindleSpeed);
          F =
            properties.feedrateMode === "revolution"
              ? tool.getThreadPitch()
              : tappingFPM;
          writeBlock(
            gRetractModal.format(98),
            gCycleModal.format(74),
            getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
            "P" + milliFormat.format(P),
            feedOutput.format(F)
          );
        }
        break;
      case "right-tapping":
        if (properties.useRigidTapping != "no") {
          writeBlock(mFormat.format(29), sOutput.format(spindleSpeed));
        }
        if (properties.usePitchForTapping) {
          writeBlock(
            gRetractModal.format(98),
            gFeedModeModal.format(95),
            gCycleModal.format(84),
            getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
            "P" + milliFormat.format(P),
            pitchOutput.format(tool.threadPitch)
          );
          resetFeedOutput();
        } else {
          var tappingFPM =
            tool.getThreadPitch() * rpmFormat.getResultingValue(spindleSpeed);
          F =
            properties.feedrateMode === "revolution"
              ? tool.getThreadPitch()
              : tappingFPM;
          writeBlock(
            gRetractModal.format(98),
            gCycleModal.format(84),
            getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
            "P" + milliFormat.format(P),
            feedOutput.format(F)
          );
        }
        break;
      case "tapping-with-chip-breaking":
      case "left-tapping-with-chip-breaking":
      case "right-tapping-with-chip-breaking":
        if (properties.useRigidTapping != "no") {
          writeBlock(mFormat.format(29), sOutput.format(spindleSpeed));
        }
        if (properties.usePitchForTapping) {
          writeBlock(
            gRetractModal.format(98),
            gFeedModeModal.format(95),
            gCycleModal.format(tool.type == TOOL_TAP_LEFT_HAND ? 74 : 84),
            getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
            "P" + milliFormat.format(P),
            "Q" + xyzFormat.format(cycle.incrementalDepth),
            pitchOutput.format(tool.threadPitch)
          );
          resetFeedOutput();
        } else {
          var tappingFPM =
            tool.getThreadPitch() * rpmFormat.getResultingValue(spindleSpeed);
          F =
            properties.feedrateMode === "revolution"
              ? tool.getThreadPitch()
              : tappingFPM;
          writeBlock(
            gRetractModal.format(98),
            gCycleModal.format(tool.type == TOOL_TAP_LEFT_HAND ? 74 : 84),
            getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
            "P" + milliFormat.format(P),
            "Q" + xyzFormat.format(cycle.incrementalDepth),
            feedOutput.format(F)
          );
        }
        break;
      case "fine-boring":
        writeBlock(
          gRetractModal.format(98),
          gCycleModal.format(76),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          "P" + milliFormat.format(P), // not optional
          "Q" + xyzFormat.format(cycle.shift),
          feedOutput.format(F)
        );
        break;
      case "back-boring":
        var dx = gPlaneModal.getCurrent() == 19 ? cycle.backBoreDistance : 0;
        var dy = gPlaneModal.getCurrent() == 18 ? cycle.backBoreDistance : 0;
        var dz = gPlaneModal.getCurrent() == 17 ? cycle.backBoreDistance : 0;
        writeBlock(
          gRetractModal.format(98),
          gCycleModal.format(87),
          getCommonCycle(x - dx, y - dy, z - dz, cycle.bottom, cycle.clearance),
          "Q" + xyzFormat.format(cycle.shift),
          "P" + milliFormat.format(P), // not optional
          feedOutput.format(F)
        );
        break;
      case "reaming":
        if (P > 0) {
          writeBlock(
            gRetractModal.format(98),
            gCycleModal.format(89),
            getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
            "P" + milliFormat.format(P),
            feedOutput.format(F)
          );
        } else {
          writeBlock(
            gRetractModal.format(98),
            gCycleModal.format(85),
            getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
            feedOutput.format(F)
          );
        }
        break;
      case "stop-boring":
        if (P > 0) {
          expandCyclePoint(x, y, z);
        } else {
          writeBlock(
            gRetractModal.format(98),
            gCycleModal.format(86),
            getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
            feedOutput.format(F)
          );
        }
        break;
      case "manual-boring":
        writeBlock(
          gRetractModal.format(98),
          gCycleModal.format(88),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          "P" + milliFormat.format(P), // not optional
          feedOutput.format(F)
        );
        break;
      case "boring":
        if (P > 0) {
          writeBlock(
            gRetractModal.format(98),
            gCycleModal.format(89),
            getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
            "P" + milliFormat.format(P), // not optional
            feedOutput.format(F)
          );
        } else {
          writeBlock(
            gRetractModal.format(98),
            gCycleModal.format(85),
            getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
            feedOutput.format(F)
          );
        }
        break;
      case "probing-x":
        resetXYZOutput();
        // move slowly always from clearance not retract
        writeBlock(
          gCode(65),
          "P" + 9810,
          zOutput.format(z - cycle.depth),
          getFeed(F)
        ); // protected positioning move
        writeBlock(
          gCode(65),
          "P" + 9811,
          "X" +
            xyzFormat.format(
              x +
                approach(cycle.approach1) *
                  (cycle.probeClearance + tool.diameter / 2)
            ),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "S" + probeWorkOffsetCode // toolFormat.format(probeToolDiameterOffset)
        );
        break;
      case "probing-y":
        resetXYZOutput();
        writeBlock(
          gCode(65),
          "P" + 9810,
          zOutput.format(z - cycle.depth),
          getFeed(F)
        ); // protected positioning move
        writeBlock(
          gCode(65),
          "P" + 9811,
          "Y" +
            xyzFormat.format(
              y +
                approach(cycle.approach1) *
                  (cycle.probeClearance + tool.diameter / 2)
            ),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "S" + probeWorkOffsetCode // toolFormat.format(probeToolDiameterOffset)
        );
        break;
      case "probing-z":
        resetXYZOutput();
        writeBlock(
          gCode(65),
          "P" + 9810,
          zOutput.format(
            Math.min(z - cycle.depth + cycle.probeClearance, cycle.retract)
          ),
          getFeed(F)
        ); // protected positioning move
        writeBlock(
          gCode(65),
          "P" + 9811,
          "Z" + xyzFormat.format(z - cycle.depth),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "S" + probeWorkOffsetCode // toolFormat.format(probeToolLengthOffset)
        );
        break;
      case "probing-x-wall":
        writeBlock(gCode(65), "P" + 9810, zOutput.format(z), getFeed(F)); // protected positioning move
        writeBlock(
          gCode(65),
          "P" + 9812,
          "X" + xyzFormat.format(cycle.width1),
          zOutput.format(z - cycle.depth),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(cycle.probeClearance),
          "S" + probeWorkOffsetCode // toolFormat.format(probeToolDiameterOffset)
        );
        break;
      case "probing-y-wall":
        writeBlock(gCode(65), "P" + 9810, zOutput.format(z), getFeed(F)); // protected positioning move
        writeBlock(
          gCode(65),
          "P" + 9812,
          "Y" + xyzFormat.format(cycle.width1),
          zOutput.format(z - cycle.depth),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(cycle.probeClearance),
          "S" + probeWorkOffsetCode // toolFormat.format(probeToolDiameterOffset)
        );
        break;
      case "probing-x-channel":
        writeBlock(
          gCode(65),
          "P" + 9810,
          zOutput.format(z - cycle.depth),
          getFeed(F)
        ); // protected positioning move
        writeBlock(
          gCode(65),
          "P" + 9812,
          "X" + xyzFormat.format(cycle.width1),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          // not required "R" + xyzFormat.format(cycle.probeClearance),
          "S" + probeWorkOffsetCode // toolFormat.format(probeToolDiameterOffset)
        );
        break;
      case "probing-x-channel-with-island":
        writeBlock(gCode(65), "P" + 9810, zOutput.format(z), getFeed(F)); // protected positioning move
        writeBlock(
          gCode(65),
          "P" + 9812,
          "X" + xyzFormat.format(cycle.width1),
          zOutput.format(z - cycle.depth),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(-cycle.probeClearance),
          "S" + probeWorkOffsetCode
        );
        break;
      case "probing-y-channel":
        yOutput.reset();
        writeBlock(
          gCode(65),
          "P" + 9810,
          zOutput.format(z - cycle.depth),
          getFeed(F)
        ); // protected positioning move
        writeBlock(
          gCode(65),
          "P" + 9812,
          "Y" + xyzFormat.format(cycle.width1),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          // not required "R" + xyzFormat.format(cycle.probeClearance),
          "S" + probeWorkOffsetCode
        );
        break;
      case "probing-y-channel-with-island":
        yOutput.reset();
        writeBlock(gCode(65), "P" + 9810, zOutput.format(z), getFeed(F)); // protected positioning move
        writeBlock(
          gCode(65),
          "P" + 9812,
          "Y" + xyzFormat.format(cycle.width1),
          zOutput.format(z - cycle.depth),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(-cycle.probeClearance),
          "S" + probeWorkOffsetCode
        );
        break;
      case "probing-xy-circular-boss":
        writeBlock(gCode(65), "P" + 9810, zOutput.format(z), getFeed(F)); // protected positioning move
        writeBlock(
          gCode(65),
          "P" + 9814,
          "D" + xyzFormat.format(cycle.width1),
          "Z" + xyzFormat.format(z - cycle.depth),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(cycle.probeClearance),
          "S" + probeWorkOffsetCode
        );
        break;
      case "probing-xy-circular-hole":
        writeBlock(
          gCode(65),
          "P" + 9810,
          zOutput.format(z - cycle.depth),
          getFeed(F)
        ); // protected positioning move
        writeBlock(
          gCode(65),
          "P" + 9814,
          "D" + xyzFormat.format(cycle.width1),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          // not required "R" + xyzFormat.format(cycle.probeClearance),
          "S" + probeWorkOffsetCode
        );
        break;
      case "probing-xy-circular-hole-with-island":
        writeBlock(gCode(65), "P" + 9810, zOutput.format(z), getFeed(F)); // protected positioning move
        writeBlock(
          gCode(65),
          "P" + 9814,
          "Z" + xyzFormat.format(z - cycle.depth),
          "D" + xyzFormat.format(cycle.width1),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(-cycle.probeClearance),
          "S" + probeWorkOffsetCode
        );
        break;
      case "probing-xy-rectangular-hole":
        writeBlock(
          gCode(65),
          "P" + 9810,
          zOutput.format(z - cycle.depth),
          getFeed(F)
        ); // protected positioning move
        writeBlock(
          gCode(65),
          "P" + 9812,
          "X" + xyzFormat.format(cycle.width1),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          // not required "R" + xyzFormat.format(-cycle.probeClearance),
          "S" + probeWorkOffsetCode
        );
        writeBlock(
          gCode(65),
          "P" + 9812,
          "Y" + xyzFormat.format(cycle.width2),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          // not required "R" + xyzFormat.format(-cycle.probeClearance),
          "S" + probeWorkOffsetCode
        );
        break;
      case "probing-xy-rectangular-boss":
        writeBlock(gCode(65), "P" + 9810, zOutput.format(z), getFeed(F)); // protected positioning move
        writeBlock(
          gCode(65),
          "P" + 9812,
          "Z" + xyzFormat.format(z - cycle.depth),
          "X" + xyzFormat.format(cycle.width1),
          "R" + xyzFormat.format(cycle.probeClearance),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "S" + probeWorkOffsetCode
        );
        writeBlock(
          gCode(65),
          "P" + 9812,
          "Z" + xyzFormat.format(z - cycle.depth),
          "Y" + xyzFormat.format(cycle.width2),
          "R" + xyzFormat.format(cycle.probeClearance),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "S" + probeWorkOffsetCode
        );
        break;
      case "probing-xy-rectangular-hole-with-island":
        writeBlock(gCode(65), "P" + 9810, zOutput.format(z), getFeed(F)); // protected positioning move
        writeBlock(
          gCode(65),
          "P" + 9812,
          "Z" + xyzFormat.format(z - cycle.depth),
          "X" + xyzFormat.format(cycle.width1),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(-cycle.probeClearance),
          "S" + probeWorkOffsetCode
        );
        writeBlock(
          gCode(65),
          "P" + 9812,
          "Z" + xyzFormat.format(z - cycle.depth),
          "Y" + xyzFormat.format(cycle.width2),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(-cycle.probeClearance),
          "S" + probeWorkOffsetCode
        );
        break;
      case "probing-xy-inner-corner":
        var cornerX =
          x +
          approach(cycle.approach1) *
            (cycle.probeClearance + tool.diameter / 2);
        var cornerY =
          y +
          approach(cycle.approach2) *
            (cycle.probeClearance + tool.diameter / 2);
        var cornerI = 0;
        var cornerJ = 0;
        if (cycle.probeSpacing !== undefined) {
          cornerI = cycle.probeSpacing;
          cornerJ = cycle.probeSpacing;
        }
        if (cornerI != 0 && cornerJ != 0) {
          g68RotationMode = 2;
        }
        writeBlock(
          gCode(65),
          "P" + 9810,
          zOutput.format(z - cycle.depth),
          getFeed(F)
        ); // protected positioning move
        writeBlock(
          gCode(65),
          "P" + 9815,
          xOutput.format(cornerX),
          yOutput.format(cornerY),
          conditional(cornerI != 0, "I" + xyzFormat.format(cornerI)),
          conditional(cornerJ != 0, "J" + xyzFormat.format(cornerJ)),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          conditional(
            g68RotationMode == 0 || angularProbingMode == ANGLE_PROBE_USE_CAXIS,
            "S" + probeWorkOffsetCode
          )
        );
        break;
      case "probing-xy-outer-corner":
        var cornerX =
          x +
          approach(cycle.approach1) *
            (cycle.probeClearance + tool.diameter / 2);
        var cornerY =
          y +
          approach(cycle.approach2) *
            (cycle.probeClearance + tool.diameter / 2);
        var cornerI = 0;
        var cornerJ = 0;
        if (cycle.probeSpacing !== undefined) {
          cornerI = cycle.probeSpacing;
          cornerJ = cycle.probeSpacing;
        }
        if (cornerI != 0 && cornerJ != 0) {
          g68RotationMode = 2;
        }
        writeBlock(
          gCode(65),
          "P" + 9810,
          zOutput.format(z - cycle.depth),
          getFeed(F)
        ); // protected positioning move
        writeBlock(
          gCode(65),
          "P" + 9816,
          xOutput.format(cornerX),
          yOutput.format(cornerY),
          conditional(cornerI != 0, "I" + xyzFormat.format(cornerI)),
          conditional(cornerJ != 0, "J" + xyzFormat.format(cornerJ)),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          conditional(
            g68RotationMode == 0 || angularProbingMode == ANGLE_PROBE_USE_CAXIS,
            "S" + probeWorkOffsetCode
          )
        );
        break;
      case "probing-x-plane-angle":
        resetXYZOutput();
        writeBlock(
          gCode(65),
          "P" + 9810,
          zOutput.format(z - cycle.depth),
          getFeed(F)
        ); // protected positioning move
        writeBlock(
          gCode(65),
          "P" + 9843,
          "X" +
            xyzFormat.format(
              x +
                approach(cycle.approach1) *
                  (cycle.probeClearance + tool.diameter / 2)
            ),
          "D" + xyzFormat.format(cycle.probeSpacing),
          "Q" + xyzFormat.format(cycle.probeOvertravel)
        );
        g68RotationMode = 1;
        break;
      case "probing-y-plane-angle":
        resetXYZOutput();
        writeBlock(
          gCode(65),
          "P" + 9810,
          zOutput.format(z - cycle.depth),
          getFeed(F)
        ); // protected positioning move
        writeBlock(
          gCode(65),
          "P" + 9843,
          "Y" +
            xyzFormat.format(
              y +
                approach(cycle.approach1) *
                  (cycle.probeClearance + tool.diameter / 2)
            ),
          "D" + xyzFormat.format(cycle.probeSpacing),
          "Q" + xyzFormat.format(cycle.probeOvertravel)
        );
        g68RotationMode = 1;
        break;
      default:
        expandCyclePoint(x, y, z);
    }

    // place cycle operation in subprogram
    if (cycleSubprogramIsActive) {
      if (forceCycle || cycleExpanded || isProbeOperation()) {
        cycleSubprogramIsActive = false;
      } else {
        // call subprogram
        writeBlock(mFormat.format(98), "P" + oFormat.format(currentSubprogram));
        subprogramStart(new Vector(x, y, z), new Vector(0, 0, 0), false);
      }
    }
    if (incrementalMode) {
      // set current position to clearance height
      setCyclePosition(cycle.clearance);
    }

    // 2nd through nth cycle point
  } else {
    if (isProbeOperation()) {
      // do nothing
    } else if (cycleExpanded) {
      expandCyclePoint(x, y, z);
    } else {
      if (
        !xyzFormat.areDifferent(x, xOutput.getCurrent()) &&
        !xyzFormat.areDifferent(y, yOutput.getCurrent()) &&
        !xyzFormat.areDifferent(z, zOutput.getCurrent())
      ) {
        switch (gPlaneModal.getCurrent()) {
          case 17: // XY
            xOutput.reset(); // at least one axis is required
            break;
          case 18: // ZX
            zOutput.reset(); // at least one axis is required
            break;
          case 19: // YZ
            yOutput.reset(); // at least one axis is required
            break;
        }
      }
      if (incrementalMode) {
        // set current position to retract height
        setCyclePosition(cycle.retract);
      }
      writeBlock(xOutput.format(x), yOutput.format(y), zOutput.format(z));
      if (incrementalMode) {
        // set current position to clearance height
        setCyclePosition(cycle.clearance);
      }
    }
  }
}

function onCycleEnd() {
  if (isProbeOperation()) {
    writeBlock(gCode(65), "P" + 9810, zOutput.format(cycle.clearance)); // protected retract move
    writeBlock(gCode(65), "P" + 9833); // spin the probe off
    setProbingAngle(); // define rotation of part
    // we can move in rapid from retract optionally
  } else {
    if (cycleSubprogramIsActive) {
      subprogramEnd();
      cycleSubprogramIsActive = false;
    }
    if (!cycleExpanded) {
      writeBlock(gCycleModal.format(GCODES.CANCEL_CANNED_CYCLE));
      // writeBlock(gCycleModal.format(GCODES.CANCEL_CANNED_CYCLE), zOutput.reset())
    }
  }
}

function onPassThrough(text) {
  var commands = String(text).split(",");
  for (text in commands) {
    writeBlock(commands[text]);
  }
}

function onParameter(name, value) {
  if (name == "probe-output-work-offset") {
    probeOutputWorkOffset = value > 0 ? value : 1;
  }
}

var pendingRadiusCompensation = -1;

function onRadiusCompensation() {
  pendingRadiusCompensation = radiusCompensation;
}

function onRapid(_x, _y, _z) {
  var x = xOutput.format(_x);
  var y = yOutput.format(_y);
  var z = zOutput.format(_z);
  if (x || y || z) {
    if (pendingRadiusCompensation >= 0) {
      error(
        localize(
          "Radius compensation mode cannot be changed at rapid traversal."
        )
      );
      return;
    }
    writeBlock(gMotionModal.format(GCODES.MOVE_RAPID), x, y, z);
    resetFeedOutput();
  }
}

function onLinear(_x, _y, _z, feed) {
  var x = xOutput.format(_x);
  var y = yOutput.format(_y);
  var z = zOutput.format(_z);
  var f = getFeed(feed);
  if (x || y || z) {
    if (pendingRadiusCompensation >= 0) {
      pendingRadiusCompensation = -1;
      var d = tool.diameterOffset;
      if (d > 99) {
        warning(localize("The diameter offset exceeds the maximum value."));
      }
      writeBlock(gPlaneModal.format(17));
      switch (radiusCompensation) {
        case RADIUS_COMPENSATION_LEFT:
          dOutput.reset();
          writeBlock(
            gMotionModal.format(GCODES.MOVE_LINEAR),
            gCode(GCODES.TOOL_RADIUS_COMP_LEFT),
            x,
            y,
            z,
            dOutput.format(d),
            f
          );
          break;
        case RADIUS_COMPENSATION_RIGHT:
          dOutput.reset();
          writeBlock(
            gMotionModal.format(GCODES.MOVE_LINEAR),
            gCode(GCODES.TOOL_RADIUS_COMP_RIGHT),
            x,
            y,
            z,
            dOutput.format(d),
            f
          );
          break;
        default:
          writeBlock(
            gMotionModal.format(GCODES.MOVE_LINEAR),
            gCode(GCODES.TOOL_RADIUS_COMP_OFF),
            x,
            y,
            z,
            f
          );
      }
    } else {
      writeBlock(gMotionModal.format(GCODES.MOVE_LINEAR), x, y, z, f);
    }
  } else if (f) {
    if (getNextRecord().isMotion()) {
      // try not to output feed without motion
      resetFeedOutput(); // force feed on next line
    } else {
      writeBlock(gMotionModal.format(GCODES.MOVE_LINEAR), f);
    }
  }
}

function onRapid5D(_x, _y, _z, _a, _b, _c) {
  if (pendingRadiusCompensation >= 0) {
    error(
      localize("Radius compensation mode cannot be changed at rapid traversal.")
    );
    return;
  }
  if (currentSection.isOptimizedForMachine()) {
    var x = xOutput.format(_x);
    var y = yOutput.format(_y);
    var z = zOutput.format(_z);
    var a = aOutput.format(_a);
    var b = bOutput.format(_b);
    var c = cOutput.format(_c);
    writeBlock(gMotionModal.format(GCODES.MOVE_RAPID), x, y, z, a, b, c);
  } else {
    resetXYZOutput();
    var x = xOutput.format(_x);
    var y = yOutput.format(_y);
    var z = zOutput.format(_z);
    var i = ijkFormat.format(_a);
    var j = ijkFormat.format(_b);
    var k = ijkFormat.format(_c);
    writeBlock(
      gMotionModal.format(GCODES.MOVE_RAPID),
      x,
      y,
      z,
      "I" + i,
      "J" + j,
      "K" + k
    );
  }
  resetFeedOutput();
}

function onLinear5D(_x, _y, _z, _a, _b, _c, feed) {
  if (pendingRadiusCompensation >= 0) {
    error(
      localize(
        "Radius compensation cannot be activated/deactivated for 5-axis move."
      )
    );
    return;
  }

  if (currentSection.isOptimizedForMachine()) {
    var x = xOutput.format(_x);
    var y = yOutput.format(_y);
    var z = zOutput.format(_z);
    var a = aOutput.format(_a);
    var b = bOutput.format(_b);
    var c = cOutput.format(_c);
    var f = getFeed(feed);
    if (x || y || z || a || b || c) {
      writeBlock(gMotionModal.format(GCODES.MOVE_LINEAR), x, y, z, a, b, c, f);
    } else if (f) {
      if (getNextRecord().isMotion()) {
        // try not to output feed without motion
        resetFeedOutput(); // force feed on next line
      } else {
        writeBlock(gMotionModal.format(GCODES.MOVE_LINEAR), f);
      }
    }
  } else {
    resetXYZOutput();
    var x = xOutput.format(_x);
    var y = yOutput.format(_y);
    var z = zOutput.format(_z);
    var i = ijkFormat.format(_a);
    var j = ijkFormat.format(_b);
    var k = ijkFormat.format(_c);
    var f = getFeed(feed);
    if (x || y || z || i || j || k) {
      writeBlock(
        gMotionModal.format(GCODES.MOVE_LINEAR),
        x,
        y,
        z,
        "I" + i,
        "J" + j,
        "K" + k,
        f
      );
    } else if (f) {
      if (getNextRecord().isMotion()) {
        // try not to output feed without motion
        resetFeedOutput(); // force feed on next line
      } else {
        writeBlock(gMotionModal.format(GCODES.MOVE_LINEAR), f);
      }
    }
  }
}

function onCircular(clockwise, cx, cy, cz, x, y, z, feed) {
  if (pendingRadiusCompensation >= 0) {
    error(
      localize(
        "Radius compensation cannot be activated/deactivated for a circular move."
      )
    );
    return;
  }

  var start = getCurrentPosition();

  if (isFullCircle()) {
    if (properties.useRadius || isHelical()) {
      // radius mode does not support full arcs
      linearize(tolerance);
      return;
    }
    switch (getCircularPlane()) {
      case PLANE_XY:
        writeBlock(
          gPlaneModal.format(17),
          gMotionModal.format(clockwise ? 2 : 3),
          iOutput.format(cx - start.x, 0),
          jOutput.format(cy - start.y, 0),
          getFeed(feed)
        );
        break;
      case PLANE_ZX:
        writeBlock(
          gPlaneModal.format(18),
          gMotionModal.format(clockwise ? 2 : 3),
          iOutput.format(cx - start.x, 0),
          kOutput.format(cz - start.z, 0),
          getFeed(feed)
        );
        break;
      case PLANE_YZ:
        writeBlock(
          gPlaneModal.format(19),
          gMotionModal.format(clockwise ? 2 : 3),
          jOutput.format(cy - start.y, 0),
          kOutput.format(cz - start.z, 0),
          getFeed(feed)
        );
        break;
      default:
        linearize(tolerance);
    }
  } else if (!properties.useRadius) {
    switch (getCircularPlane()) {
      case PLANE_XY:
        writeBlock(
          gPlaneModal.format(17),
          gMotionModal.format(clockwise ? 2 : 3),
          xOutput.format(x),
          yOutput.format(y),
          zOutput.format(z),
          iOutput.format(cx - start.x, 0),
          jOutput.format(cy - start.y, 0),
          getFeed(feed)
        );
        break;
      case PLANE_ZX:
        writeBlock(
          gPlaneModal.format(18),
          gMotionModal.format(clockwise ? 2 : 3),
          xOutput.format(x),
          yOutput.format(y),
          zOutput.format(z),
          iOutput.format(cx - start.x, 0),
          kOutput.format(cz - start.z, 0),
          getFeed(feed)
        );
        break;
      case PLANE_YZ:
        writeBlock(
          gPlaneModal.format(19),
          gMotionModal.format(clockwise ? 2 : 3),
          xOutput.format(x),
          yOutput.format(y),
          zOutput.format(z),
          jOutput.format(cy - start.y, 0),
          kOutput.format(cz - start.z, 0),
          getFeed(feed)
        );
        break;
      default:
        if (properties.allow3DArcs) {
          // make sure maximumCircularSweep is well below 360deg
          // we could use G02.4 or G03.4 - direction is calculated
          var ip = getPositionU(0.5);
          writeBlock(
            gMotionModal.format(clockwise ? 2.4 : 3.4),
            xOutput.format(ip.x),
            yOutput.format(ip.y),
            zOutput.format(ip.z),
            getFeed(feed)
          );
          writeBlock(xOutput.format(x), yOutput.format(y), zOutput.format(z));
        } else {
          linearize(tolerance);
        }
    }
  } else {
    // use radius mode
    var r = getCircularRadius();
    if (toDeg(getCircularSweep()) > 180 + 1e-9) {
      r = -r; // allow up to <360 deg arcs
    }
    switch (getCircularPlane()) {
      case PLANE_XY:
        writeBlock(
          gPlaneModal.format(17),
          gMotionModal.format(clockwise ? 2 : 3),
          xOutput.format(x),
          yOutput.format(y),
          zOutput.format(z),
          "R" + rFormat.format(r),
          getFeed(feed)
        );
        break;
      case PLANE_ZX:
        writeBlock(
          gPlaneModal.format(18),
          gMotionModal.format(clockwise ? 2 : 3),
          xOutput.format(x),
          yOutput.format(y),
          zOutput.format(z),
          "R" + rFormat.format(r),
          getFeed(feed)
        );
        break;
      case PLANE_YZ:
        writeBlock(
          gPlaneModal.format(19),
          gMotionModal.format(clockwise ? 2 : 3),
          xOutput.format(x),
          yOutput.format(y),
          zOutput.format(z),
          "R" + rFormat.format(r),
          getFeed(feed)
        );
        break;
      default:
        if (properties.allow3DArcs) {
          // make sure maximumCircularSweep is well below 360deg
          // we could use G02.4 or G03.4 - direction is calculated
          var ip = getPositionU(0.5);
          writeBlock(
            gMotionModal.format(clockwise ? 2.4 : 3.4),
            xOutput.format(ip.x),
            yOutput.format(ip.y),
            zOutput.format(ip.z),
            getFeed(feed)
          );
          writeBlock(xOutput.format(x), yOutput.format(y), zOutput.format(z));
        } else {
          linearize(tolerance);
        }
    }
  }
}

var currentCoolantMode = COOLANT_OFF;
var coolantOff = undefined;

function setCoolant(coolant) {
  var coolantCodes = getCoolantCodes(coolant);
  if (Array.isArray(coolantCodes)) {
    for (var c in coolantCodes) {
      writeBlock(coolantCodes[c]);
    }
    return undefined;
  }
  return coolantCodes;
}

function getCoolantCodes(coolant) {
  if (!coolants) {
    error(localize("Coolants have not been defined."));
  }
  if (!coolantOff) {
    // use the default coolant off command when an 'off' value is not specified for the previous coolant mode
    coolantOff = coolants.off;
  }

  if (isProbeOperation()) {
    // avoid coolant output for probing
    coolant = COOLANT_OFF;
  }

  if (coolant == currentCoolantMode) {
    return undefined; // coolant is already active
  }

  var multipleCoolantBlocks = new Array(); // create a formatted array to be passed into the outputted line
  if (coolant != COOLANT_OFF && currentCoolantMode != COOLANT_OFF) {
    multipleCoolantBlocks.push(mFormat.format(coolantOff));
  }

  var m;
  if (coolant == COOLANT_OFF) {
    m = coolantOff;
    coolantOff = coolants.off;
  }

  switch (coolant) {
    case COOLANT_FLOOD:
      if (!coolants.flood) {
        break;
      }
      m = coolants.flood.on;
      coolantOff = coolants.flood.off;
      break;
    case COOLANT_THROUGH_TOOL:
      if (!coolants.throughTool) {
        break;
      }
      m = coolants.throughTool.on;
      coolantOff = coolants.throughTool.off;
      break;
    case COOLANT_AIR:
      if (!coolants.air) {
        break;
      }
      m = coolants.air.on;
      coolantOff = coolants.air.off;
      break;
    case COOLANT_AIR_THROUGH_TOOL:
      if (!coolants.airThroughTool) {
        break;
      }
      m = coolants.airThroughTool.on;
      coolantOff = coolants.airThroughTool.off;
      break;
    case COOLANT_FLOOD_MIST:
      if (!coolants.floodMist) {
        break;
      }
      m = coolants.floodMist.on;
      coolantOff = coolants.floodMist.off;
      break;
    case COOLANT_MIST:
      if (!coolants.mist) {
        break;
      }
      m = coolants.mist.on;
      coolantOff = coolants.mist.off;
      break;
    case COOLANT_SUCTION:
      if (!coolants.suction) {
        break;
      }
      m = coolants.suction.on;
      coolantOff = coolants.suction.off;
      break;
    case COOLANT_FLOOD_THROUGH_TOOL:
      if (!coolants.floodThroughTool) {
        break;
      }
      m = coolants.floodThroughTool.on;
      coolantOff = coolants.floodThroughTool.off;
      break;
  }

  if (!m) {
    onUnsupportedCoolant(coolant);
    m = 9;
  }

  if (m) {
    if (Array.isArray(m)) {
      for (var i in m) {
        multipleCoolantBlocks.push(mFormat.format(m[i]));
      }
    } else {
      multipleCoolantBlocks.push(mFormat.format(m));
    }
    currentCoolantMode = coolant;
    return multipleCoolantBlocks; // return the single formatted coolant value
  }
  return undefined;
}

/**
 Buffer Manual NC commands for processing later
*/
var bufferPassThrough = false; // enable to output the Pass Through commands until after ending the previous section
var manualNC = [];
function onManualNC(command, value) {
  if (command == COMMAND_PASS_THROUGH && bufferPassThrough) {
    manualNC.push({ command: command, value: value });
  } else {
    expandManualNC(command, value);
  }
}

/**
 Processes the Manual NC commands
 Pass the desired command to process or leave argument list blank to process all buffered commands
*/
function executeManualNC(command) {
  for (var i = 0; i < manualNC.length; ++i) {
    if (!command || command == manualNC[i].command) {
      expandManualNC(manualNC[i].command, manualNC[i].value);
    }
  }
  for (var i = manualNC.length - 1; i >= 0; --i) {
    if (!command || command == manualNC[i].command) {
      manualNC.splice(i, 1);
    }
  }
}

var mapCommand = {
  COMMAND_STOP: 0,
  COMMAND_OPTIONAL_STOP: 1,
  COMMAND_END: 2,
  COMMAND_SPINDLE_CLOCKWISE: 3,
  COMMAND_SPINDLE_COUNTERCLOCKWISE: 4,
  COMMAND_STOP_SPINDLE: 5,
  COMMAND_ORIENTATE_SPINDLE: 19,
};

function onCommand(command) {
  switch (command) {
    case COMMAND_COOLANT_OFF:
      setCoolant(COOLANT_OFF);
      return;
    case COMMAND_COOLANT_ON:
      setCoolant(COOLANT_FLOOD);
      return;
    case COMMAND_STOP:
      writeBlock(mFormat.format(0));
      forceSpindleSpeed = true;
      return;
    case COMMAND_START_SPINDLE:
      onCommand(
        tool.clockwise
          ? COMMAND_SPINDLE_CLOCKWISE
          : COMMAND_SPINDLE_COUNTERCLOCKWISE
      );
      return;
    case COMMAND_LOCK_MULTI_AXIS:
      return;
    case COMMAND_UNLOCK_MULTI_AXIS:
      return;
    case COMMAND_START_CHIP_TRANSPORT:
      return;
    case COMMAND_STOP_CHIP_TRANSPORT:
      return;
    case COMMAND_BREAK_CONTROL:
      return;
    case COMMAND_TOOL_MEASURE:
      return;
  }

  var stringId = getCommandStringId(command);
  var mcode = mapCommand[stringId];
  if (mcode != undefined) {
    writeBlock(mFormat.format(mcode));
  } else {
    onUnsupportedCommand(command);
  }
}

function onSectionEnd() {
  if (
    isVeryLastSection(currentSection) ||
    toolWillChange(tool, getNextSection())
  ) {
    onCommand(COMMAND_BREAK_CONTROL);
  }
  if (!isLastSection() && getNextSection().getTool().coolant != tool.coolant) {
    setCoolant(COOLANT_OFF);
  }

  if (isRedirecting()) {
    if (firstPattern) {
      var finalPosition = getFramePosition(currentSection.getFinalPosition());
      var abc;
      if (
        currentSection.isMultiAxis() &&
        machineConfiguration.isMultiAxisConfiguration()
      ) {
        abc = currentSection.getFinalToolAxisABC();
      } else {
        abc = currentWorkPlaneABC;
      }
      if (abc == undefined) {
        abc = new Vector(0, 0, 0);
      }
      setAbsoluteMode(finalPosition, abc);
      subprogramEnd();
    }
  }

  if (
    isVeryLastSection(currentSection) ||
    toolWillChange(tool, getNextSection())
  ) {
    writeEndOfSection();
  }
}

function writeRetract() {
  // initialize routine
  var _xyzMoved = new Array(false, false, false);
  var _useG28 = properties.useG28; // can be either true or false

  // check syntax of call
  if (arguments.length == 0) {
    error(localize("No axis specified for writeRetract()."));
    return;
  }
  for (var i = 0; i < arguments.length; ++i) {
    if (arguments[i] < 0 || arguments[i] > 2) {
      error(localize("Bad axis specified for writeRetract()."));
      return;
    }
    if (_xyzMoved[arguments[i]]) {
      error(localize("Cannot retract the same axis twice in one line"));
      return;
    }
    _xyzMoved[arguments[i]] = true;
  }

  // special conditions

  // define home positions
  var _xHome;
  var _yHome;
  var _zHome;
  if (_useG28) {
    _xHome = 0;
    _yHome = 0;
    _zHome = 0;
  } else {
    _xHome = machineConfiguration.hasHomePositionX()
      ? machineConfiguration.getHomePositionX()
      : 0;
    _yHome = machineConfiguration.hasHomePositionY()
      ? machineConfiguration.getHomePositionY()
      : 0;
    _zHome = machineConfiguration.getRetractPlane();
  }

  // format home positions
  var words = []; // store all retracted axes in an array
  for (var i = 0; i < arguments.length; ++i) {
    // define the axes to move
    switch (arguments[i]) {
      case X:
        if (!machineConfiguration.hasHomePositionX()) {
          _useG28 = true;
        }
        words.push("X" + xyzFormat.format(_xHome));
        break;
      case Y:
        if (!machineConfiguration.hasHomePositionY()) {
          _useG28 = true;
        }
        words.push("Y" + xyzFormat.format(_yHome));
        break;
      case Z:
        words.push("Z" + xyzFormat.format(_zHome));
        retracted = true;
        break;
    }
  }

  // output move to home
  if (words.length > 0) {
    if (_useG28) {
      gAbsIncModal.reset();
      writeBlock(
        gCode(GCODES.HOMING),
        gAbsIncModal.format(GCODES.MOVEMENT_MODE_INCREMENTAL),
        words
      );
      writeBlock(gAbsIncModal.format(GCODES.MOVEMENT_MODE_ABSOLUTE));
    } else {
      gMotionModal.reset();
      writeBlock(
        gAbsIncModal.format(GCODES.MOVEMENT_MODE_ABSOLUTE),
        gCode(53),
        gMotionModal.format(GCODES.MOVE_RAPID),
        words
      );
    }

    // force any axes that move to home on next block
    if (_xyzMoved[0]) {
      xOutput.reset();
    }
    if (_xyzMoved[1]) {
      yOutput.reset();
    }
    if (_xyzMoved[2]) {
      zOutput.reset();
    }
  }
}

function writeBlock() {
  var text = formatWords(arguments);
  if (!text) {
    return;
  }
  if (properties.showSequenceNumbers) {
    if (optionalSection) {
      if (text) {
        writeWords("/", "N" + sequenceNumber, text);
      }
    } else {
      writeWords2("N" + sequenceNumber, arguments);
    }
    sequenceNumber += properties.sequenceNumberIncrement;
  } else {
    if (optionalSection) {
      writeWords2("/", arguments);
    } else {
      writeWords(arguments);
    }
  }
}

function writeOptionalBlock() {
  if (properties.showSequenceNumbers) {
    var words = formatWords(arguments);
    if (words) {
      writeWords("/", "N" + sequenceNumber, words);
      sequenceNumber += properties.sequenceNumberIncrement;
    }
  } else {
    writeWords2("/", arguments);
  }
}

function formatComment(text) {
  return (
    "(" +
    filterText(String(text).toUpperCase(), permittedCommentChars).replace(
      /[()]/g,
      ""
    ) +
    ")"
  );
}

function writeComment(text) {
  writeln(formatComment(text));
}

function onComment(message) {
  var comments = String(message).split(";");
  for (comment in comments) {
    writeComment(comments[comment]);
  }
}

function setupManyAxisMachine() {
  var aAxis = createAxis({
    coordinate: 0,
    table: false,
    axis: [1, 0, 0],
    range: [-360, 360],
    preference: 1,
  });
  var cAxis = createAxis({
    coordinate: 2,
    table: false,
    axis: [0, 0, 1],
    range: [-360, 360],
    preference: 1,
  });
  machineConfiguration = new MachineConfiguration(aAxis, cAxis);

  setMachineConfiguration(machineConfiguration);
  optimizeMachineAngles2(0); // TCP mode

  return machineConfiguration;
}

///
/// Machine Defaults
///
function writeSafeBlock() {
  var safeBlockCommands = [];

  if (unit === MM) {
    safeBlockCommands.push(gCode(GCODES.UNITS_MM));
  } else {
    safeBlockCommands.push(gCode(GCODES.UNITS_IN));
  }

  var initialMovementMode = GCODES.MOVEMENT_MODE_ABSOLUTE;
  safeBlockCommands.push(gCode(initialMovementMode));

  switch (properties.feedrateMode) {
    case "minute":
      safeBlockCommands.push(gCode(GCODES.FEEDRATE_PER_MINUTE));
      break;
    case "revolution":
      safeBlockCommands.push(gCode(GCODES.FEEDRATE_PER_REVOLUTION));
      break;
  }

  safeBlockCommands.push(gCode(GCODES.TOOL_LENGTH_OFFSET_COMP_CANCEL));
  lengthCompensationActive = false;
  safeBlockCommands.push(gCode(GCODES.TOOL_RADIUS_COMP_OFF));
  safeBlockCommands.push(gCode(GCODES.CANCEL_CANNED_CYCLE));

  writeBlock.apply(null, safeBlockCommands);

  // make sure plane motion modal gets set specifically and don't just write the gcode anywhere *shrug* -AM 10092020
  switch (properties.planeMode) {
    case "XY":
      writeBlock(gPlaneModal.format(GCODES.PLANE_MODE_XY));
      break;
    case "ZX":
      writeBlock(gPlaneModal.format(GCODES.PLANE_MODE_ZX));
      break;
    case "YZ":
      writeBlock(gPlaneModal.format(GCODES.PLANE_MODE_YZ));
      break;
  }
}

function writeProgramName() {
  var programId;
  try {
    programId = getAsInt(programName);
  } catch (e) {
    error(localize("Program name must be a number."));
    return;
  }
  if (properties.o8) {
    if (!(programId >= 1 && programId <= 99999999)) {
      error(localize("Program number is out of range."));
      return;
    }
  } else {
    if (!(programId >= 1 && programId <= 9999)) {
      error(localize("Program number is out of range."));
      return;
    }
  }
  if (programId >= 8000 && programId <= 9999) {
    warning(localize("Program number is reserved by tool builder."));
  }
  if (programComment) {
    writeln(
      "O" + oFormat.format(programId) + " " + formatComment(programComment)
    );
  } else {
    writeln("O" + oFormat.format(programId));
  }
  lastSubprogram = programId;
}

function writeMachineInfo(machineConfiguration) {
  var vendor = machineConfiguration.getVendor();
  var model = machineConfiguration.getModel();
  var description = machineConfiguration.getDescription();

  if (vendor || model || description) {
    writeComment(localize("Machine"));
    if (vendor) {
      writeComment("  " + localize("vendor") + ": " + vendor);
    }
    if (model) {
      writeComment("  " + localize("model") + ": " + model);
    }
    if (description) {
      writeComment("  " + localize("description") + ": " + description);
    }
  }
}

function writeToolsInfo() {
  var zRanges = {};
  if (is3D()) {
    var numberOfSections = getNumberOfSections();
    for (var i = 0; i < numberOfSections; ++i) {
      var section = getSection(i);
      var zRange = section.getGlobalZRange();
      var tool = section.getTool();
      if (zRanges[tool.number]) {
        zRanges[tool.number].expandToRange(zRange);
      } else {
        zRanges[tool.number] = zRange;
      }
    }
  }

  var tools = getToolTable();
  if (tools.getNumberOfTools() > 0) {
    for (var i = 0; i < tools.getNumberOfTools(); ++i) {
      var tool = tools.getTool(i);
      var comment =
        toolFormat.format(tool.number) +
        " " +
        "D=" +
        xyzFormat.format(tool.diameter) +
        " " +
        localize("CR") +
        "=" +
        xyzFormat.format(tool.cornerRadius);
      if (tool.taperAngle > 0 && tool.taperAngle < Math.PI) {
        comment +=
          " " +
          localize("TAPER") +
          "=" +
          taperFormat.format(tool.taperAngle) +
          localize("deg");
      }
      if (zRanges[tool.number]) {
        comment +=
          " - " +
          localize("ZMIN") +
          "=" +
          xyzFormat.format(zRanges[tool.number].getMinimum());
      }
      comment += " - " + getToolTypeName(tool.type);
      writeComment(comment);
    }
  }
}

function errorDuplicateToolNumbers() {
  for (var i = 0; i < getNumberOfSections(); ++i) {
    var sectioni = getSection(i);
    var tooli = sectioni.getTool();
    for (var j = i + 1; j < getNumberOfSections(); ++j) {
      var sectionj = getSection(j);
      var toolj = sectionj.getTool();
      if (tooli.number == toolj.number) {
        if (
          xyzFormat.areDifferent(tooli.diameter, toolj.diameter) ||
          xyzFormat.areDifferent(tooli.cornerRadius, toolj.cornerRadius) ||
          abcFormat.areDifferent(tooli.taperAngle, toolj.taperAngle) ||
          tooli.numberOfFlutes != toolj.numberOfFlutes
        ) {
          error(
            subst(
              localize(
                "Using the same tool number for different cutter geometry for operation '%1' and '%2'."
              ),
              sectioni.hasParameter("operation-comment")
                ? sectioni.getParameter("operation-comment")
                : "#" + (i + 1),
              sectionj.hasParameter("operation-comment")
                ? sectionj.getParameter("operation-comment")
                : "#" + (j + 1)
            )
          );
          return true;
        }
      }
    }
  }
}

function errorOffsetConfig() {
  if (getNumberOfSections() > 0 && getSection(0).workOffset == 0) {
    for (var i = 0; i < getNumberOfSections(); ++i) {
      if (getSection(i).workOffset > 0) {
        error(
          localize(
            "Using multiple work offsets is not possible if the initial work offset is 0."
          )
        );
        return true;
      }
    }
  }
}

function errorFeedrateConfig() {
  if (
    properties.feedrateMode === "revolution" &&
    properties.useParametricFeed
  ) {
    error(
      localize(
        "Parametric feed is not supported when using G95 (feedrate per revolution)."
      )
    );
    return true;
  }
}

function resetXYZOutput() {
  xOutput.reset();
  yOutput.reset();
  zOutput.reset();
}

function resetABCOutput() {
  aOutput.reset();
  bOutput.reset();
  cOutput.reset();
}

function resetFeedOutput() {
  currentFeedId = undefined;
  feedOutput.reset();
}

/** reset axis outputs to force printout on next line */
function resetAxisOutputs() {
  resetXYZOutput();
  resetABCOutput();
  resetFeedOutput();
}

function gCode(val) {
  return gFormat.format(val);
}

function mCode(val) {
  return mFormat.format(val);
}

function writeLineBreak() {
  writeln("");
}

function parameterEq(str, value, section) {
  switch (section) {
    case SECTIONS.PREVIOUS:
      return (
        getPreviousSection().hasParameter(str) &&
        getPreviousSection().getParameter(str) === value
      );
    case SECTIONS.NEXT:
      return (
        getNextSection().hasParameter(str) &&
        getNextSection().getParameter(str) === value
      );
  }
  return hasParameter(str) && getParameter(str) === value;
}

function writeSectionNumber() {
  if (properties.showSectionNumbers) {
    writeln(nFormat.format(sectionNumber));
    sectionNumber++;
  }
}

function writeToolComment() {
  if (hasParameter("operation-comment")) {
    var comment = getParameter("operation-comment");
    if (
      comment &&
      (comment !== lastOperationComment || !patternIsActive || toolChanged)
    ) {
      var toolComments = [comment, toolFormat.format(tool.number)];
      if (tool.comment) toolComments.push(tool.comment);
      writeComment(toolComments.join(" __ "));
      lastOperationComment = comment;
    }
  }
}

function writeNotes() {
  if (properties.showNotes && hasParameter("notes")) {
    var notes = getParameter("notes");
    if (notes) {
      var lines = String(notes).split("\n");
      var r1 = new RegExp("^[\\s]+", "g");
      var r2 = new RegExp("[\\s]+$", "g");
      for (line in lines) {
        var comment = lines[line].replace(r1, "").replace(r2, "");
        if (comment) {
          writeComment(comment);
        }
      }
    }
  }
}

function writeEndOfSection() {
  // coming one line too late...
  writeBlock(mCode(MCODES.STOP_SPINDLE));
  writeBlock(mCode(MCODES.COOLANT_OFF));
  currentCoolantMode = COOLANT_OFF;
  writeBlock(
    gCode(GCODES.HOMING),
    gCode(GCODES.MOVEMENT_MODE_INCREMENTAL),
    zOutput.format(0)
  );
  if (!isLastSection()) {
    writeBlock(onCommand(COMMAND_OPTIONAL_STOP));
  }
}

function isVeryLastSection(section) {
  return section.getId() + 1 >= getNumberOfSections();
}

function toolWillChange(currentTool, nextSection) {
  if (nextSection != null) {
    return currentTool.number != nextSection.getTool().number;
  }
  return false;
}
