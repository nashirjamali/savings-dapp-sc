import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("SimpleSavings", (m) => {
    const simpleSavings = m.contract("SimpleSavings");

    return { simpleSavings };
});