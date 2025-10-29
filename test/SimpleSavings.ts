import { equal } from "assert";
import hre from "hardhat";
import { assert, test } from "node:test";

test("should deposit funds to the contract", async () => {
    const { viem } = await hre.network.connect();
    const [bobWalletClient, _] = await viem.getWalletClients();
    const simpleSavings = await viem.deployContract("SimpleSavings");

    const depositAmount = 100n;

    await viem.assertions.emit(
        bobWalletClient.writeContract({
            address: simpleSavings.address,
            abi: simpleSavings.abi,
            functionName: "deposit",
            args: [],
            value: depositAmount,
        }),
        simpleSavings,
        "Deposited",
    );
});

test("should withdraw funds from the contract", async () => {
    const { viem } = await hre.network.connect();
    const [bobWalletClient, _] = await viem.getWalletClients();
    const simpleSavings = await viem.deployContract("SimpleSavings");

    const depositAmount = 100n;
    const withdrawAmount = 50n;

    await bobWalletClient.writeContract({
        address: simpleSavings.address,
        abi: simpleSavings.abi,
        functionName: "deposit",
        args: [],
        value: depositAmount,
    });

    await viem.assertions.emit(
        bobWalletClient.writeContract({
            address: simpleSavings.address,
            abi: simpleSavings.abi,
            functionName: "withdraw",
            args: [withdrawAmount],
        }),
        simpleSavings,
        "Withdrawn",
    );
});