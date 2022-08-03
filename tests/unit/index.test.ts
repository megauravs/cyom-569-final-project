import { APIGatewayProxyEvent, APIGatewayProxyResult } from "aws-lambda";
import { handler } from "../../src/index";

jest.mock("aws-sdk");
const docClient = new (jest.requireMock("aws-sdk").DynamoDB.DocumentClient)() as jest.Mocked<
    AWS.DynamoDB.DocumentClient
>;

describe('Unit test for app handler', function () {
    it('verifies that handler handles error', async () => {
        const event: APIGatewayProxyEvent = {
            queryStringParameters: {
                a: "1"
            }
        } as any
        const result = await handler(event);
        expect(result).toEqual({
            statusCode: 404,
            body: "No handler for routeKey undefined undefined."
        });
    });
});